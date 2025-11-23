impl Solution {
    pub fn longest_palindrome(s: String) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut max_len = 0;

        for i in 0..n {
            for j in i..n {
                let mut is_palindrome = true;
                let mut left = i;
                let mut right = j;
                while left < right {
                    if s[left] != s[right] {
                        is_palindrome = false;
                        break;
                    }
                    left += 1;
                    right -= 1;
                }
                if is_palindrome && (j - i + 1) > max_len {
                    max_len = j - i + 1;
                }
            }
        }
        max_len as i32
    }
}