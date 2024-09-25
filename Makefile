# cargo install cargo-watch
dev:
	cargo watch -x check -x test -x run

fmt:
	cargo fmt

check: fmt
	cargo check

PATTERN?="update_db"
test: check
	cargo test ${PATTERN}

test-verbose: check
	cargo test -- --nocapture

# cargo install cargo-tarpaulin
cov:
	cargo tarpaulin --ignore-tests

# rustup component add clippy
lint-check: check
	cargo clippy -- -D warnings

# rustup component add rustfmt, for CI pipeline
fmt-check:
	cargo fmt -- --check

# cargo install cargo-audit
audit:
	cargo audit

# cargo install cargo-deny
# equivalent to cargo-audit
deny-audit:
	cargo deny

build:
	cargo build

# cargo install cargo-asm
asm:
	cargo asm

# cargo install bunyan
test-log:
	export RUST_LOG="sqlx=error,info"
	export TEST_LOG=true
	cargo test ${PATTERN} | bunyan

show-todos:
	grep -rni ./src -e 'todo'
	grep -rni ./tests -e 'todo'
# Link to the kata
# https://github.com/jepsen-io/maelstrom
mealstrom-serve:
	~/devel/personal/maelstrom/maelstrom test -w echo --bin target/debug/rustigeon --node-count 1 --time-limit 10

mealstrom-test-echo:
	~/devel/personal/maelstrom/maelstrom test -w echo --bin target/debug/echo --node-count 1 --time-limit 10
