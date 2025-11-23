impl Solution {
    pub fn reverse(x: i32) -> i32 {
        let mut num = x;
        let mut rev: i32 = 0;

        while num != 0 {
            let digit = num % 10;

            // Check for overflow before updating rev
            // i32::MAX = 2147483647
            // i32::MIN = -2147483648

            if rev > i32::MAX / 10 || (rev == i32::MAX / 10 && digit > 7) {
                return 0;
            }
            if rev < i32::MIN / 10 || (rev == i32::MIN / 10 && digit < -8) {
                return 0;
            }

            rev = rev * 10 + digit;
            num /= 10;
        }

        rev
    }
}