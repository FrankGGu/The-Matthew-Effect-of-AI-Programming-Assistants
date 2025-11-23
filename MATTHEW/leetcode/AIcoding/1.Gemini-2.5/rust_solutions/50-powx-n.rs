impl Solution {
    pub fn my_pow(x: f64, n: i32) -> f64 {
        let mut res = 1.0;
        let mut base = x;
        let mut power = n as i64;

        if power < 0 {
            base = 1.0 / base;
            power = -power;
        }

        while power > 0 {
            if power % 2 == 1 {
                res *= base;
            }
            base *= base;
            power /= 2;
        }

        res
    }
}