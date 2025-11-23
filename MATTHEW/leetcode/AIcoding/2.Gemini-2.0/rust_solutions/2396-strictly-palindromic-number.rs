impl Solution {
    pub fn is_strictly_palindromic(n: i32) -> bool {
        for base in 2..=n - 2 {
            let mut num = n;
            let mut digits = Vec::new();
            while num > 0 {
                digits.push(num % base);
                num /= base;
            }
            let len = digits.len();
            for i in 0..len / 2 {
                if digits[i] != digits[len - 1 - i] {
                    return false;
                }
            }
        }
        true
    }
}