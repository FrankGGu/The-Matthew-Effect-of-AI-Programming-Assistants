impl Solution {
    pub fn clear_stars(s: String) -> String {
        let mut stack: Vec<char> = Vec::new();
        for c in s.chars() {
            if c == '*' {
                if !stack.is_empty() {
                    stack.pop();
                }
            } else {
                stack.push(c);
            }
        }
        stack.into_iter().collect()
    }
}