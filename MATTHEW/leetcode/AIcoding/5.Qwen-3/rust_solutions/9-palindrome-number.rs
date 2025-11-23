struct Solution;

impl Solution {
    pub fn is_palindrome(x: i32) -> bool {
        if x < 0 {
            return false;
        }
        let mut num = x;
        let mut reversed = 0;
        while num > 0 {
            let digit = num % 10;
            reversed = reversed * 10 + digit;
            num /= 10;
        }
        x == reversed
    }
}