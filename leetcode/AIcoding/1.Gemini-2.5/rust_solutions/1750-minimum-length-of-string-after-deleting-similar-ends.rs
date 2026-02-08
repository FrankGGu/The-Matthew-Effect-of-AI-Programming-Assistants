impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = s_chars.len() - 1;

        while left < right && s_chars[left] == s_chars[right] {
            let ch = s_chars[left];

            while left <= right && s_chars[left] == ch {
                left += 1;
            }

            while left <= right && s_chars[right] == ch {
                right -= 1;
            }
        }

        (right - left + 1).max(0) as i32
    }
}