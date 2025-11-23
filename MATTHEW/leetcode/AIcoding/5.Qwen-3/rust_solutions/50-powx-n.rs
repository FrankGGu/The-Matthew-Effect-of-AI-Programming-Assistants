struct Solution {}

impl Solution {
    pub fn my_pow(x: f64, n: i32) -> f64 {
        if n == 0 {
            return 1.0;
        }
        let mut power = n;
        let mut base = x;
        let mut result = 1.0;
        if power < 0 {
            base = 1.0 / base;
            power = -power;
        }
        while power > 0 {
            if power % 2 == 1 {
                result *= base;
            }
            base *= base;
            power /= 2;
        }
        result
    }
}