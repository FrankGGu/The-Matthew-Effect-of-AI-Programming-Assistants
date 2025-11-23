impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_monotonic_pairs(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n];
        let mut map = HashMap::new();

        for i in 0..n {
            let val = nums[i];
            let count = *map.get(&val).unwrap_or(&0);
            dp[i] = count;
            map.insert(val, count + 1);
        }

        dp.iter().sum()
    }
}
}