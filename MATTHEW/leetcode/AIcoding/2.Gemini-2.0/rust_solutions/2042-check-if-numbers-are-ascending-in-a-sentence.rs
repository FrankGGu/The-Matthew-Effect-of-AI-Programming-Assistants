impl Solution {
    pub fn are_numbers_ascending(s: String) -> bool {
        let mut prev = 0;
        for word in s.split_whitespace() {
            if let Ok(num) = word.parse::<i32>() {
                if num <= prev {
                    return false;
                }
                prev = num;
            }
        }
        true
    }
}