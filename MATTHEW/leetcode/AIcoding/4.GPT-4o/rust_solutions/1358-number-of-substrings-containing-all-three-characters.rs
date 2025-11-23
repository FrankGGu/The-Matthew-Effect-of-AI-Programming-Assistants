impl Solution {
    pub fn number_of_substrings(s: String) -> i32 {
        let (mut left, mut right) = (0, 0);
        let mut count = 0;
        let mut char_count = [0; 3];

        let s_bytes = s.as_bytes();
        let total_length = s.len();

        while right < total_length {
            char_count[(s_bytes[right] - b'a') as usize] += 1;

            while char_count[0] > 0 && char_count[1] > 0 && char_count[2] > 0 {
                count += total_length - right;
                char_count[(s_bytes[left] - b'a') as usize] -= 1;
                left += 1;
            }
            right += 1;
        }

        count
    }
}