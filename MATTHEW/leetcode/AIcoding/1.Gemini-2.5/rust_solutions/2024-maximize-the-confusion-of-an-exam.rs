impl Solution {
    fn solve(s: &str, k: i32, target_char: char) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut count_flips = 0;
        let mut max_len = 0;

        for right in 0..n {
            if chars[right] != target_char {
                count_flips += 1;
            }

            while count_flips > k {
                if chars[left] != target_char {
                    count_flips -= 1;
                }
                left += 1;
            }

            max_len = max_len.max((right - left + 1) as i32);
        }
        max_len
    }

    pub fn max_consecutive_answers(answer: String, k: i32) -> i32 {
        let max_t = Self::solve(&answer, k, 'T');
        let max_f = Self::solve(&answer, k, 'F');
        max_t.max(max_f)
    }
}