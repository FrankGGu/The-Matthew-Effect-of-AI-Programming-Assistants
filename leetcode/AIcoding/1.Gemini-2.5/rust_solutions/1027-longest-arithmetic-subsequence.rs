use std::collections::HashMap;

impl Solution {
    pub fn longest_arith_seq(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 2 {
            return n as i32;
        }

        let mut dp: Vec<HashMap<i32, i32>> = vec![HashMap::new(); n];
        let mut max_len = 2; 

        for i in 0..n {
            for j in 0..i {
                let diff = nums[i] - nums[j];

                let len_at_j = *dp[j].get(&diff).unwrap_or(&1);

                let current_len = len_at_j + 1;

                dp[i].entry(diff).and_modify(|e| *e = std::cmp::max(*e, current_len)).or_insert(current_len);

                max_len = std::cmp::max(max_len, current_len);
            }
        }

        max_len
    }
}