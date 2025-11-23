impl Solution {
    pub fn backspace_compare(s: String, t: String) -> bool {
        fn process_string(s: String) -> String {
            let mut result = Vec::new();
            for c in s.chars() {
                if c == '#' {
                    result.pop();
                } else {
                    result.push(c);
                }
            }
            result.into_iter().collect()
        }

        process_string(s) == process_string(t)
    }
}