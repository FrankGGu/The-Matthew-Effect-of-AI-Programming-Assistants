impl Solution {
    pub fn is_strictly_palindromic(n: i32) -> bool {
        for base in 2..=n - 2 {
            let mut num = n;
            let mut digits = Vec::new();
            while num > 0 {
                digits.push(num % base);
                num /= base;
            }
            if !digits.iter().eq(digits.iter().rev()) {
                return false;
            }
        }
        true
    }
}