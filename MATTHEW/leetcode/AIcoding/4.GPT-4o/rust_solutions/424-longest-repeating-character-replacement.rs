impl Solution {
    pub fn character_replacement(s: String, k: i32) -> i32 {
        let bytes = s.as_bytes();
        let mut count = [0; 26];
        let (mut left, mut max_count, mut max_length) = (0, 0, 0);

        for right in 0..bytes.len() {
            let index = (bytes[right] - b'A') as usize;
            count[index] += 1;
            max_count = max_count.max(count[index]);

            while right - left + 1 - max_count > k {
                count[(bytes[left] - b'A') as usize] -= 1;
                left += 1;
            }

            max_length = max_length.max(right - left + 1);
        }

        max_length
    }
}