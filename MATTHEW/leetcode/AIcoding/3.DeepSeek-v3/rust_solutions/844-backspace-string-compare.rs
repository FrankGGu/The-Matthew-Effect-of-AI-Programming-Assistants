impl Solution {
    pub fn backspace_compare(s: String, t: String) -> bool {
        fn process_string(s: String) -> Vec<char> {
            let mut stack = Vec::new();
            for c in s.chars() {
                if c == '#' {
                    stack.pop();
                } else {
                    stack.push(c);
                }
            }
            stack
        }

        process_string(s) == process_string(t)
    }
}