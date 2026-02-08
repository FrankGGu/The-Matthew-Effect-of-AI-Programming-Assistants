impl Solution {
    pub fn my_pow(x: f64, n: i32) -> f64 {
        if n == 0 {
            return 1.0;
        }
        let mut n = n as i64;
        if n < 0 {
            return 1.0 / Self::my_pow(x, -n as i32);
        }
        let mut result = 1.0;
        let mut current_product = x;

        while n > 0 {
            if n % 2 == 1 {
                result *= current_product;
            }
            current_product *= current_product;
            n /= 2;
        }
        result
    }
}