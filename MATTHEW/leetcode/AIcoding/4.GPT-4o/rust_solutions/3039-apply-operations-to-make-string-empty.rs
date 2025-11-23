impl Solution {
    pub fn can_be_empty(s: String, operations: Vec<String>) -> bool {
        let mut s_chars: Vec<char> = s.chars().collect();
        for op in operations {
            match op.as_str() {
                "remove" => {
                    if !s_chars.is_empty() {
                        s_chars.pop();
                    }
                }
                "remove_first" => {
                    if !s_chars.is_empty() {
                        s_chars.remove(0);
                    }
                }
                _ => {}
            }
        }
        s_chars.is_empty()
    }
}