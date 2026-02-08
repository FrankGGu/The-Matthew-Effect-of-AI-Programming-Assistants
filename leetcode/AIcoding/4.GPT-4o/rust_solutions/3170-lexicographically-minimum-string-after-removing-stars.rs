impl Solution {
    pub fn remove_stars(s: String) -> String {
        let mut result = Vec::new();
        for char in s.chars() {
            if char == '*' {
                result.pop();
            } else {
                result.push(char);
            }
        }
        result.into_iter().collect()
    }
}