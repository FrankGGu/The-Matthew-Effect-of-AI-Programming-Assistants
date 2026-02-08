impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let mut s = s.chars().collect::<Vec<_>>();
        let mut left = 0;
        let mut right = s.len() - 1;

        while left < right {
            if s[left] == s[right] {
                let char_to_remove = s[left];
                while left <= right && s[left] == char_to_remove {
                    left += 1;
                }
                while left <= right && s[right] == char_to_remove {
                    right -= 1;
                }
            } else {
                break;
            }
        }

        (right - left + 1) as i32
    }
}