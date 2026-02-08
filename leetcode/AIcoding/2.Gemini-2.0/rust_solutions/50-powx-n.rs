impl Solution {
    pub fn my_pow(x: f64, n: i32) -> f64 {
        if n == 0 {
            return 1.0;
        }

        let mut nn = n as i64;
        let mut xx = x;

        if nn < 0 {
            xx = 1.0 / x;
            nn = -nn;
        }

        let mut ans = 1.0;
        let mut current_product = xx;

        while nn > 0 {
            if nn % 2 == 1 {
                ans *= current_product;
            }
            current_product *= current_product;
            nn /= 2;
        }

        return ans;
    }
}