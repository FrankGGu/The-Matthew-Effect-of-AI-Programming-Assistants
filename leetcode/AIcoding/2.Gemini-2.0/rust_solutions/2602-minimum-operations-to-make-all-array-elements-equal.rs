use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, queries: Vec<i32>) -> Vec<i64> {
        let mut sorted_nums = nums.clone();
        sorted_nums.sort();
        let n = sorted_nums.len();
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + sorted_nums[i] as i64;
        }

        let mut result: Vec<i64> = Vec::new();
        for &query in &queries {
            let mut left = 0;
            let mut right = n;
            while left < right {
                let mid = left + (right - left) / 2;
                if sorted_nums[mid] < query {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }

            let less_count = left;
            let greater_count = n - left;

            let less_sum = prefix_sum[less_count];
            let greater_sum = prefix_sum[n] - prefix_sum[less_count];

            let less_ops = (query as i64 * less_count as i64) - less_sum;
            let greater_ops = greater_sum - (query as i64 * greater_count as i64);

            result.push(less_ops + greater_ops);
        }

        result
    }
}