use std::collections::HashMap;

const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn sum_counts(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total = 0;
        for i in 0..n {
            let mut distinct = HashMap::new();
            for j in i..n {
                *distinct.entry(nums[j]).or_insert(0) += 1;
                let k = distinct.len() as i64;
                total = (total + k * k) % MOD;
            }
        }
        total as i32
    }
}