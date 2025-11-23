struct Solution;

impl Solution {
    pub fn are_numbers_ascending(s: String) -> bool {
        let mut prev = 0;
        for token in s.split_whitespace() {
            if let Ok(num) = token.parse::<i32>() {
                if num <= prev {
                    return false;
                }
                prev = num;
            }
        }
        true
    }
}