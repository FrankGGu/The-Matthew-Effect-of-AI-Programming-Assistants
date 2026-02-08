impl Solution {
    pub fn maximum_length_substring(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mut counts = [0; 26];
        let mut max_len = 0;
        let mut left = 0;

        for right in 0..n {
            let char_idx = (s_bytes[right] - b'a') as usize;
            counts[char_idx] += 1;

            while counts[char_idx] > 2 {
                let left_char_idx = (s_bytes[left] - b'a') as usize;
                counts[left_char_idx] -= 1;
                left += 1;
            }

            max_len = max_len.max(right - left + 1);
        }

        max_len as i32
    }
}