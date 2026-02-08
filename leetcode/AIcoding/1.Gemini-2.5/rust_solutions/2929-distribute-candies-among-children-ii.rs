impl Solution {
    pub fn distribute_candies(k: i32, limit: i32) -> i64 {
        let k_long = k as i64;
        let limit_long = limit as i64;

        fn combinations_2(n_val: i64) -> i64 {
            if n_val < 2 {
                0
            } else {
                n_val * (n_val - 1) / 2
            }
        }

        let term1 = combinations_2(k_long + 2);
        let term2 = 3 * combinations_2(k_long - limit_long + 1);
        let term3 = 3 * combinations_2(k_long - 2 * limit_long);
        let term4 = 1 * combinations_2(k_long - 3 * limit_long - 1);

        term1 - term2 + term3 - term4
    }
}