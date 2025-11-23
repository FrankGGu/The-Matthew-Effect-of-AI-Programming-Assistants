impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let mut chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = chars.len() as i32 - 1;

        while left < right {
            if chars[left] == chars[right] {
                let char_to_remove = chars[left];
                while left <= right && chars[left] == char_to_remove {
                    left += 1;
                }
                while left <= right && chars[right] == char_to_remove {
                    right -= 1;
                }
            } else {
                break;
            }
        }

        (right - left + 1) as i32
    }
}