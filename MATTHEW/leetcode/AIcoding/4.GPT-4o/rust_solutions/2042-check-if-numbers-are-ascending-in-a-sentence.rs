impl Solution {
    pub fn are_numbers_ascending(s: String) -> bool {
        let mut last_num = 0;
        for word in s.split_whitespace() {
            if let Ok(num) = word.parse::<i32>() {
                if num <= last_num {
                    return false;
                }
                last_num = num;
            }
        }
        true
    }
}