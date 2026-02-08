impl Solution {
    pub fn smallest_divisible_digit_product(n: i32) -> i32 {
        let mut num = n;
        while num < i32::MAX {
            let product = Self::digit_product(num);
            if product != 0 && num % product == 0 {
                return num;
            }
            num += 1;
        }
        -1
    }

    fn digit_product(mut n: i32) -> i32 {
        let mut product = 1;
        while n > 0 {
            let digit = n % 10;
            if digit == 0 {
                return 0;
            }
            product *= digit;
            n /= 10;
        }
        product
    }
}