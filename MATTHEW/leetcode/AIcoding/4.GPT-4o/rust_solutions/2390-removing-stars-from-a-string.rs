impl Solution {
    pub fn remove_stars(s: String) -> String {
        let mut stack = Vec::new();
        for char in s.chars() {
            if char == '*' {
                stack.pop();
            } else {
                stack.push(char);
            }
        }
        stack.into_iter().collect()
    }
}