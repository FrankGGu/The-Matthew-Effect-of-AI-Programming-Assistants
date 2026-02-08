impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let mut chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = chars.len() - 1;

        while left < right && chars[left] == chars[right] {
            let current = chars[left];
            while left <= right && chars[left] == current {
                left += 1;
            }
            while left <= right && chars[right] == current {
                right -= 1;
            }
        }

        (right as i32 - left as i32 + 1).max(0)
    }
}