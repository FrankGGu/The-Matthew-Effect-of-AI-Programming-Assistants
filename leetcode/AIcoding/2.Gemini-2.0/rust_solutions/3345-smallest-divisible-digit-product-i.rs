impl Solution {
    pub fn smallest_divisible_digit_product(n: i32) -> i32 {
        if n == 1 {
            return 1;
        }
        let mut digits = Vec::new();
        let mut num = n;
        for i in (2..=9).rev() {
            while num % i == 0 {
                digits.push(i);
                num /= i;
            }
        }
        if num != 1 {
            return -1;
        }
        digits.sort();
        let mut result = 0;
        for &digit in &digits {
            result = result * 10 + digit;
        }
        result
    }
}