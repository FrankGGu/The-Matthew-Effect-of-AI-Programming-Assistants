impl Solution {
    pub fn subtract_product_and_sum(n: i32) -> i32 {
        let (mut product, mut sum) = (1, 0);
        let mut num = n;

        while num > 0 {
            let digit = num % 10;
            product *= digit;
            sum += digit;
            num /= 10;
        }

        product - sum
    }
}