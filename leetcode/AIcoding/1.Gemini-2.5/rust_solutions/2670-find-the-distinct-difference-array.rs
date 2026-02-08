use std::collections::HashSet;

impl Solution {
    pub fn distinct_difference_array(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        if n == 0 {
            return Vec::new();
        }

        let mut prefix_distinct_counts = vec![0; n];
        let mut suffix_distinct_counts = vec![0; n];

        let mut set = HashSet::new();
        for i in 0..n {
            set.insert(nums[i]);
            prefix_distinct_counts[i] = set.len() as i32;
        }

        set.clear();
        for i in (0..n).rev() {
            set.insert(nums[i]);
            suffix_distinct_counts[i] = set.len() as i32;
        }

        let mut result = vec![0; n];
        for i in 0..n {
            let prefix_count = prefix_distinct_counts[i];
            let suffix_count = if i + 1 < n {
                suffix_distinct_counts[i + 1]
            } else {
                0
            };
            result[i] = prefix_count - suffix_count;
        }

        result
    }
}