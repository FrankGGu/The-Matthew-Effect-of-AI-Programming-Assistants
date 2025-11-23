impl Solution {
    pub fn smallest_divisible_digit_product(n: i32) -> i32 {
        for num in 1..=9999 {
            let mut product = 1;
            let mut temp = num;
            let mut has_zero = false;
            while temp > 0 {
                let digit = temp % 10;
                if digit == 0 {
                    has_zero = true;
                    break;
                }
                product *= digit;
                temp /= 10;
            }
            if !has_zero && product != 0 && num % product == 0 && product <= n {
                return num;
            }
        }
        -1
    }
}