impl Solution {
    pub fn smallest_divisible(d: i32) -> i32 {
        let mut result = d;
        while !Self::is_product_of_digits(result) {
            result += d;
        }
        result
    }

    fn is_product_of_digits(n: i32) -> bool {
        let mut product = 1;
        let mut num = n;
        while num > 0 {
            product *= num % 10;
            num /= 10;
        }
        product % n == 0
    }
}