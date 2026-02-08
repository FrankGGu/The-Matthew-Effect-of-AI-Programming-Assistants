impl Solution {
    pub fn max_consecutive_answers(answer_key: String, k: i32) -> i32 {
        let answer_key = answer_key.as_bytes();
        let k = k as usize;
        let max_t = Self::max_consecutive_char(answer_key, b'T', k);
        let max_f = Self::max_consecutive_char(answer_key, b'F', k);
        max_t.max(max_f) as i32
    }

    fn max_consecutive_char(answer_key: &[u8], target: u8, k: usize) -> usize {
        let mut left = 0;
        let mut count = 0;
        let mut max_len = 0;

        for right in 0..answer_key.len() {
            if answer_key[right] != target {
                count += 1;
            }
            while count > k {
                if answer_key[left] != target {
                    count -= 1;
                }
                left += 1;
            }
            max_len = max_len.max(right - left + 1);
        }
        max_len
    }
}