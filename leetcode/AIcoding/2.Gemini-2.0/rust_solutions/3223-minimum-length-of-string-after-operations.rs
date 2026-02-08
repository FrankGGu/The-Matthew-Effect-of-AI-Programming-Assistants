impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let mut s_chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = s_chars.len() - 1;

        while left < right && s_chars[left] == s_chars[right] {
            let common_char = s_chars[left];
            while left <= right && s_chars[left] == common_char {
                left += 1;
            }
            while left <= right && s_chars[right] == common_char {
                right -= 1;
            }
        }

        (right as i32 - left as i32 + 1).max(0)
    }
}