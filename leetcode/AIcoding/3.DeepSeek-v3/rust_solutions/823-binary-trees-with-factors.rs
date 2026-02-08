use std::collections::HashMap;

impl Solution {
    pub fn num_factored_binary_trees(arr: Vec<i32>) -> i32 {
        let modulo = 1_000_000_007;
        let mut arr = arr;
        arr.sort_unstable();
        let mut dp = HashMap::new();
        let mut res = 0;

        for &num in &arr {
            dp.insert(num, 1);
            for &left in &arr {
                if left >= num {
                    break;
                }
                if num % left == 0 {
                    let right = num / left;
                    if dp.contains_key(&right) {
                        let count = dp[&left] as i64 * dp[&right] as i64 % modulo;
                        *dp.get_mut(&num).unwrap() = (*dp[&num] as i64 + count) % modulo;
                    }
                }
            }
            res = (res + dp[&num] as i64) % modulo;
        }

        res as i32
    }
}