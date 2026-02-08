impl Solution {
    pub fn character_replacement(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let mut count = [0; 26];
        let mut max_count = 0;
        let mut left = 0;
        let mut result = 0;
        let k = k as usize;

        for right in 0..s.len() {
            let idx = (s[right] - b'A') as usize;
            count[idx] += 1;
            max_count = max_count.max(count[idx]);

            while (right - left + 1) - max_count > k {
                let left_idx = (s[left] - b'A') as usize;
                count[left_idx] -= 1;
                left += 1;
            }

            result = result.max(right - left + 1);
        }

        result as i32
    }
}