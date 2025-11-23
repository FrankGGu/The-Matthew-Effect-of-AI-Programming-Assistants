use std::collections::HashMap;

impl Solution {
    pub fn count_interesting_subarrays(nums: Vec<i32>, modulo: i32, k: i32) -> i64 {
        let mut ans: i64 = 0;
        let mut current_sum: i64 = 0;
        let mut freq: HashMap<i32, i32> = HashMap::new();
        freq.insert(0, 1);

        for x in nums {
            let b_val = if x % modulo == k { 1 } else { 0 };
            current_sum += b_val;

            let current_sum_mod = (current_sum % (modulo as i64)) as i32;

            let target_rem = (current_sum_mod - k + modulo) % modulo;

            ans += *freq.get(&target_rem).unwrap_or(&0) as i64;

            *freq.entry(current_sum_mod).or_insert(0) += 1;
        }

        ans
    }
}