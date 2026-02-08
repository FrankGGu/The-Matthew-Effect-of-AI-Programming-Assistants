impl Solution {
    pub fn is_palindrome(x: i32) -> bool {
        if x < 0 {
            return false;
        }
        let mut reversed: i32 = 0;
        let mut original: i32 = x;
        while original > 0 {
            if reversed > i32::MAX / 10 {
                return false;
            }
            reversed = reversed * 10 + original % 10;
            original /= 10;
        }
        x == reversed
    }
}