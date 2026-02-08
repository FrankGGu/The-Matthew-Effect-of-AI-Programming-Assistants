impl Solution {
    pub fn truncate_sentence(s: String, k: i32) -> String {
        let mut count = 0;
        let mut result = String::new();
        for c in s.chars() {
            if c == ' ' {
                count += 1;
                if count == k {
                    break;
                }
            }
            result.push(c);
        }
        result
    }
}