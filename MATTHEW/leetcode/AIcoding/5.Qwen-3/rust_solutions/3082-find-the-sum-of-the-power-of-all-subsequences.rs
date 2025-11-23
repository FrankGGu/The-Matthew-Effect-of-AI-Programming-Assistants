impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sum_of_powers(nums: Vec<i32>) -> i32 {
        let mod_val = 10i64.pow(9) + 7;
        let mut dp = HashMap::new();
        dp.insert(0, 0);

        for &num in &nums {
            let mut new_dp = dp.clone();
            for (&mask, &val) in &dp {
                let new_mask = mask | (1 << num);
                let new_val = val * num;
                *new_dp.entry(new_mask).or_insert(0) = (*new_dp.get(&new_mask).unwrap() + new_val) % mod_val;
            }
            dp = new_dp;
        }

        let mut total = 0;
        for &val in dp.values() {
            total = (total + val) % mod_val;
        }
        total as i32
    }
}
}