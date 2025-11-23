impl Solution {
    pub fn character_replacement(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut max_len = 0;
        let mut count = [0; 26];
        let mut max_count = 0;
        let mut left = 0;

        for right in 0..n {
            let index = (s[right] - b'A') as usize;
            count[index] += 1;
            max_count = max_count.max(count[index]);

            while right - left + 1 - max_count as usize > k as usize {
                let index = (s[left] - b'A') as usize;
                count[index] -= 1;
                left += 1;
            }

            max_len = max_len.max(right - left + 1);
        }

        max_len as i32
    }
}