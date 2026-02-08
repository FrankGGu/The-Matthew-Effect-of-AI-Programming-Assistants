impl Solution {
    pub fn max_consecutive_answers(answer_key: String, k: i32) -> i32 {
        let s = answer_key.as_bytes();
        let n = s.len();
        let mut max_len = 0;

        for c in ['T' as u8, 'F' as u8] {
            let mut left = 0;
            let mut flips = 0;
            for right in 0..n {
                if s[right] != c {
                    flips += 1;
                }
                while flips > k {
                    if s[left] != c {
                        flips -= 1;
                    }
                    left += 1;
                }
                max_len = max_len.max(right as i32 - left as i32 + 1);
            }
        }
        max_len
    }
}