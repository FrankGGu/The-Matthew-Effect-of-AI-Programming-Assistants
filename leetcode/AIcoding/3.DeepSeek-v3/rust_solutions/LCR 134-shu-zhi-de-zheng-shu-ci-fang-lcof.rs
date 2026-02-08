impl Solution {
    pub fn my_pow(x: f64, n: i32) -> f64 {
        fn helper(x: f64, n: i64) -> f64 {
            if n == 0 {
                return 1.0;
            }
            let half = helper(x, n / 2);
            if n % 2 == 0 {
                half * half
            } else {
                half * half * x
            }
        }

        let res = helper(x, n as i64);
        if n >= 0 {
            res
        } else {
            1.0 / res
        }
    }
}