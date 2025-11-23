impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn get_subarray_medians(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut count = HashMap::new();
        let mut res = 0;
        let mut prefix = 0;
        count.insert(0, 1);

        for i in 0..n {
            if nums[i] > k {
                prefix += 1;
            } else if nums[i] < k {
                prefix -= 1;
            }

            if let Some(&v) = count.get(&prefix) {
                res += v;
            }

            *count.entry(prefix).or_insert(0) += 1;
        }

        res
    }
}
}