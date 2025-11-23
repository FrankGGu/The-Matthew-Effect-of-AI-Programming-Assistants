impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_monotonic_pairs(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n];
        let mut count = 0;
        let mut map = HashMap::new();

        for i in 0..n {
            let val = nums[i];
            let mut total = 1;
            for j in 0..i {
                if nums[j] <= val {
                    total += dp[j];
                }
            }
            dp[i] = total;
            count += total;
            *map.entry(val).or_insert(0) += 1;
        }

        count
    }
}
}