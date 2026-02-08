impl Solution {
    pub fn prime_palindrome(n: i32) -> i32 {
        if n <= 2 {
            return 2;
        }
        let mut num = n;
        loop {
            if Self::is_palindrome(num) && Self::is_prime(num) {
                return num;
            }
            num += 1;
            if 10_000_000 < num && num < 100_000_000 {
                num = 100_000_000;
            }
        }
    }

    fn is_palindrome(mut x: i32) -> bool {
        if x < 0 || (x % 10 == 0 && x != 0) {
            return false;
        }
        let mut reversed = 0;
        let original = x;
        while x > 0 {
            reversed = reversed * 10 + x % 10;
            x /= 10;
        }
        reversed == original
    }

    fn is_prime(x: i32) -> bool {
        if x <= 1 {
            return false;
        }
        if x == 2 {
            return true;
        }
        if x % 2 == 0 {
            return false;
        }
        let sqrt_x = (x as f64).sqrt() as i32;
        for i in (3..=sqrt_x).step_by(2) {
            if x % i == 0 {
                return false;
            }
        }
        true
    }
}