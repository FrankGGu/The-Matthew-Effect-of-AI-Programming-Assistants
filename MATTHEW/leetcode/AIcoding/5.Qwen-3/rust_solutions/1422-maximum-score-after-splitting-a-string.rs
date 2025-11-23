struct Solution;

impl Solution {
    pub fn max_score(s: String) -> i32 {
        let mut left = 0;
        let mut right = 0;
        for c in s.chars() {
            if c == '1' {
                right += 1;
            }
        }
        let mut max_score = 0;
        for (i, c) in s.chars().enumerate() {
            if c == '0' {
                left += 1;
            } else {
                right -= 1;
            }
            if i < s.len() - 1 {
                max_score = std::cmp::max(max_score, left + right);
            }
        }
        max_score
    }
}