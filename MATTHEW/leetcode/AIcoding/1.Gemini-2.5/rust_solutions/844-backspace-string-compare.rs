impl Solution {
    pub fn backspace_compare(s: String, t: String) -> bool {
        fn build_string(input: &str) -> Vec<char> {
            let mut stack: Vec<char> = Vec::new();
            for c in input.chars() {
                if c == '#' {
                    stack.pop();
                } else {
                    stack.push(c);
                }
            }
            stack
        }

        let processed_s = build_string(&s);
        let processed_t = build_string(&t);

        processed_s == processed_t
    }
}