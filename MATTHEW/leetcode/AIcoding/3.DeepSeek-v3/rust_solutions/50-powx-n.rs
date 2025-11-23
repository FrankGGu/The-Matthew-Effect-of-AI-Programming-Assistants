impl Solution {
    pub fn my_pow(x: f64, n: i32) -> f64 {
        let mut x = x;
        let mut n = n as i64;
        if n < 0 {
            x = 1.0 / x;
            n = -n;
        }
        let mut res = 1.0;
        let mut current_product = x;
        while n > 0 {
            if n % 2 == 1 {
                res *= current_product;
            }
            current_product *= current_product;
            n /= 2;
        }
        res
    }
}