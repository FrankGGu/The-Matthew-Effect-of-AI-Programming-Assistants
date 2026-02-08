use std::collections::HashSet;

impl Solution {
    pub fn distinct_difference_array(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut prefix = vec![0; n];
        let mut suffix = vec![0; n];
        let mut set = HashSet::new();

        for i in 0..n {
            set.insert(nums[i]);
            prefix[i] = set.len() as i32;
        }

        set.clear();

        for i in (0..n).rev() {
            suffix[i] = set.len() as i32;
            set.insert(nums[i]);
        }

        (0..n).map(|i| prefix[i] - suffix[i]).collect()
    }
}