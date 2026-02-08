impl Solution {
    pub fn final_string(s: String) -> String {
        let mut result = String::new();
        for c in s.chars() {
            if c == 'i' {
                result = result.chars().rev().collect();
            } else {
                result.push(c);
            }
        }
        result
    }
}