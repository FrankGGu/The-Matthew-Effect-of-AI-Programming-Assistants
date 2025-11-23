struct Solution {}

impl Solution {
    pub fn my_pow(x: f64, n: i32) -> f64 {
        if n == 0 {
            return 1.0;
        }
        let mut abs_n = n.abs() as u64;
        let mut result = 1.0;
        let mut base = x;
        while abs_n > 0 {
            if abs_n % 2 == 1 {
                result *= base;
            }
            base *= base;
            abs_n /= 2;
        }
        if n < 0 {
            1.0 / result
        } else {
            result
        }
    }
}