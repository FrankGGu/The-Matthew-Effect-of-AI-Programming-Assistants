impl Solution {
    pub fn remove_stars(s: String) -> String {
        let mut stack: Vec<char> = Vec::new();
        for ch in s.chars() {
            if ch == '*' {
                stack.pop();
            } else {
                stack.push(ch);
            }
        }
        stack.into_iter().collect()
    }
}