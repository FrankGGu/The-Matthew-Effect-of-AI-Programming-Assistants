impl Solution {
    pub fn remove_palindrome_sub(s: String) -> i32 {
        if s.is_empty() {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut left = 0;
        let mut right = n - 1;

        while left < right {
            if chars[left] != chars[right] {
                return 2;
            }
            left += 1;
            right -= 1;
        }

        1
    }
}