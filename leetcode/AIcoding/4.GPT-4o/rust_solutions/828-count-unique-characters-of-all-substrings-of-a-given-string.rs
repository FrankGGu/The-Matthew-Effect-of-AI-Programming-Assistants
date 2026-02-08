impl Solution {
    pub fn unique_letter_string(s: String) -> i32 {
        let mut last_seen = vec![-1; 26];
        let mut result = 0;
        let n = s.len();
        let bytes = s.as_bytes();

        for i in 0..n {
            let char_index = (bytes[i] - b'A') as usize;
            let last_index = last_seen[char_index];
            last_seen[char_index] = i as i32;

            let unique_count = i as i32 - last_index;
            result += unique_count * (i as i32 + 1);
        }

        result
    }
}