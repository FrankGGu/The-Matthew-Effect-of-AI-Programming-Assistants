impl Solution {
    pub fn are_numbers_ascending(s: String) -> bool {
        let mut last_num = 0;
        for token in s.split_whitespace() {
            if let Ok(num) = token.parse::<i32>() {
                if num <= last_num {
                    return false;
                }
                last_num = num;
            }
        }
        true
    }
}