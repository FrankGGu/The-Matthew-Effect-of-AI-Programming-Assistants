impl Solution {
    pub fn max_consecutive_answers(answer_key: String, k: i32) -> i32 {
        let bytes = answer_key.as_bytes();
        let (mut left, mut right, mut max_count) = (0, 0, 0);
        let n = bytes.len();

        while right < n {
            if bytes[right] == b'T' {
                max_count += 1;
            }
            while max_count > k {
                if bytes[left] == b'T' {
                    max_count -= 1;
                }
                left += 1;
            }
            right += 1;
        }
        (right - left).max((n - left).max(n - right))
    }
}