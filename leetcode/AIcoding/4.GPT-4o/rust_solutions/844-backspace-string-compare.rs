impl Solution {
    pub fn backspace_compare(s: String, t: String) -> bool {
        fn process_string(s: &str) -> String {
            let mut result = Vec::new();
            for ch in s.chars() {
                if ch == '#' {
                    result.pop();
                } else {
                    result.push(ch);
                }
            }
            result.into_iter().collect()
        }
        process_string(&s) == process_string(&t)
    }
}