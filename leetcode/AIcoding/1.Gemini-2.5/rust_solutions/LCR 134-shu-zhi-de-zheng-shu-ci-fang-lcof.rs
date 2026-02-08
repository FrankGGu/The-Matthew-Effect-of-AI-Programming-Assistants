impl Solution {
    pub fn my_pow(x: f64, n: i32) -> f64 {
        let mut ans = 1.0;
        let mut base = x;
        let mut exp = n as i64;

        if exp < 0 {
            base = 1.0 / base;
            exp = -exp;
        }

        while exp > 0 {
            if exp % 2 == 1 {
                ans *= base;
            }
            base *= base;
            exp /= 2;
        }

        ans
    }
}