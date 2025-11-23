impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_beautiful_splits(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        let mut prefix = HashMap::new();
        let mut sum = 0;

        for i in 0..n {
            sum += nums[i];
            *prefix.entry(sum).or_insert(0) += 1;
        }

        sum = 0;
        for i in 0..n - 1 {
            sum += nums[i];
            let total = *prefix.get(&sum).unwrap();
            let left = *prefix.get(&sum).unwrap() - 1;
            count += left;
            *prefix.get_mut(&sum).unwrap() -= 1;
        }

        count
    }
}
}