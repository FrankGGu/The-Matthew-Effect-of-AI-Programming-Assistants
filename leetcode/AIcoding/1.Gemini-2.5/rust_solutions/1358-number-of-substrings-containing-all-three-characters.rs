impl Solution {
    pub fn number_of_substrings(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();

        let mut count = [0; 3];
        let mut left = 0;
        let mut ans = 0;

        for right in 0..n {
            let char_val = s_bytes[right];
            let char_index = (char_val - b'a') as usize;
            count[char_index] += 1;

            while count[0] > 0 && count[1] > 0 && count[2] > 0 {
                ans += (n - right) as i32;

                let left_char_val = s_bytes[left];
                let left_char_index = (left_char_val - b'a') as usize;
                count[left_char_index] -= 1;
                left += 1;
            }
        }

        ans
    }
}