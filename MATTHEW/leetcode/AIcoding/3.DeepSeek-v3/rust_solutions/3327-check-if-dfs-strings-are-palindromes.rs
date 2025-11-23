impl Solution {
    pub fn is_palindrome(s: String) -> bool {
        let s: Vec<char> = s.chars().filter(|c| c.is_alphanumeric()).map(|c| c.to_ascii_lowercase()).collect();
        let mut left = 0;
        let mut right = s.len() as i32 - 1;

        while left < right {
            if s[left as usize] != s[right as usize] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }
}