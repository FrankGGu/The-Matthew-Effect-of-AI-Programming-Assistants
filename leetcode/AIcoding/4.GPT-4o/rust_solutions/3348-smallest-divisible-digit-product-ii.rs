impl Solution {
    pub fn smallest_divisible_digit_product(n: i32) -> i32 {
        if n == 0 { return 10; }
        for i in 1..=10 {
            if n % i == 0 {
                return i;
            }
        }
        0
    }
}