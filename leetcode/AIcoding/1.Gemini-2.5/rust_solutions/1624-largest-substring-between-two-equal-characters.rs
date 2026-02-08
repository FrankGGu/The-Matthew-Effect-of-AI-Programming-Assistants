impl Solution {
    pub fn max_length_between_equal_characters(s: String) -> i32 {
        let mut first_occurrence: [i32; 26] = [-1; 26];
        let mut max_length = -1;

        for (i, &byte) in s.as_bytes().iter().enumerate() {
            let char_code = (byte - b'a') as usize;
            if first_occurrence[char_code] == -1 {
                first_occurrence[char_code] = i as i32;
            } else {
                let current_length = (i as i32) - first_occurrence[char_code] - 1;
                max_length = max_length.max(current_length);
            }
        }

        max_length
    }
}