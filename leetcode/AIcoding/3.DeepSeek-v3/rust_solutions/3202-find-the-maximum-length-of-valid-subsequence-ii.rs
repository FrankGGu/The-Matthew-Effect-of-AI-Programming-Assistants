use std::collections::HashMap;

impl Solution {
    pub fn maximum_length(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut dp = vec![vec![0; nums.len()]; k + 1];
        let mut global_max = vec![0; k + 1];
        let mut value_map = vec![HashMap::new(); k + 1];

        for i in 0..nums.len() {
            for j in (0..=k).rev() {
                let mut max_len = if j > 0 { global_max[j - 1] + 1 } else { 1 };
                if let Some(&val) = value_map[j].get(&nums[i]) {
                    max_len = max_len.max(val + 1);
                }
                dp[j][i] = max_len;

                let entry = value_map[j].entry(nums[i]).or_insert(0);
                *entry = (*entry).max(max_len);
                global_max[j] = global_max[j].max(max_len);
            }
        }

        global_max[k]
    }
}