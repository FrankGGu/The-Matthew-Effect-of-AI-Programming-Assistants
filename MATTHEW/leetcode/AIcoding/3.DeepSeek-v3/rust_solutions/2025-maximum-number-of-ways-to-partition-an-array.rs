use std::collections::HashMap;

impl Solution {
    pub fn ways_to_partition(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        let total = prefix[n];

        let mut right = HashMap::new();
        for i in 1..n {
            let sum_left = prefix[i];
            let sum_right = total - sum_left;
            *right.entry(sum_right - sum_left).or_insert(0) += 1;
        }

        let mut max_partitions = *right.get(&0).unwrap_or(&0);

        let mut left = HashMap::new();
        for i in 0..n {
            let diff = k - nums[i];
            let current = *left.get(&diff).unwrap_or(&0) + *right.get(&(-diff)).unwrap_or(&0);
            if current > max_partitions {
                max_partitions = current;
            }

            if i < n - 1 {
                let sum_left = prefix[i + 1];
                let sum_right = total - sum_left;
                let key = sum_right - sum_left;
                *right.entry(key).and_modify(|e| *e -= 1).or_insert(0);
                if right[&key] == 0 {
                    right.remove(&key);
                }
                *left.entry(sum_left - (total - sum_left)).or_insert(0) += 1;
            }
        }

        max_partitions
    }
}