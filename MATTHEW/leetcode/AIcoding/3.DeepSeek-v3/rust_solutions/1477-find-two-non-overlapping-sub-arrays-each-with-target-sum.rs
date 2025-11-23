use std::collections::HashMap;

impl Solution {
    pub fn min_sum_of_lengths(arr: Vec<i32>, target: i32) -> i32 {
        let n = arr.len();
        let mut prefix = HashMap::new();
        prefix.insert(0, -1);
        let mut sum = 0;
        let mut dp = vec![std::i32::MAX; n + 1];
        let mut res = std::i32::MAX;
        let mut min_len = std::i32::MAX;

        for i in 0..n {
            sum += arr[i];
            if let Some(&prev) = prefix.get(&(sum - target)) {
                let current_len = i as i32 - prev;
                if prev >= 0 && dp[prev as usize] != std::i32::MAX {
                    res = res.min(current_len + dp[prev as usize]);
                }
                min_len = min_len.min(current_len);
            }
            dp[i + 1] = min_len;
            prefix.insert(sum, i as i32);
        }

        if res == std::i32::MAX {
            -1
        } else {
            res
        }
    }
}