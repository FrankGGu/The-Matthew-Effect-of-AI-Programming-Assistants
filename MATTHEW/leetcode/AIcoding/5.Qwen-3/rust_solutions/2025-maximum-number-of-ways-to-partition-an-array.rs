impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_partitions(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut prefix_sum = vec![0; n];
        prefix_sum[0] = arr[0];
        for i in 1..n {
            prefix_sum[i] = prefix_sum[i - 1] + arr[i];
        }

        let total_sum = prefix_sum[n - 1];

        let mut count_map = HashMap::new();
        count_map.insert(0, 1);
        let mut result = 0;
        let mut current_sum = 0;

        for i in 0..n {
            current_sum += arr[i];
            if i < n - 1 {
                let remaining = total_sum - current_sum;
                let target = (current_sum - remaining) / 2;
                if target == 0 {
                    result += count_map.get(&0).copied().unwrap_or(0);
                } else {
                    result += count_map.get(&target).copied().unwrap_or(0);
                }
            }
            count_map.entry(current_sum).and_modify(|e| *e += 1).or_insert(1);
        }

        result
    }
}
}