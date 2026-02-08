impl Solution {
    pub fn max_score(s: String) -> i32 {
        let (mut left, mut right) = (0, s.chars().filter(|&c| c == '1').count());
        let mut max_score = 0;

        for c in s.chars().take(s.len() - 1) {
            if c == '0' {
                left += 1;
            } else {
                right -= 1;
            }
            max_score = max_score.max(left + right);
        }
        max_score
    }
}