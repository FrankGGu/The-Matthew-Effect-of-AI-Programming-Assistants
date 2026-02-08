use std::collections::HashSet;

impl Solution {
    pub fn find_largest_almost_missing(nums: Vec<i32>) -> i32 {
        let num_set: HashSet<_> = nums.iter().cloned().collect();
        let mut max_k = -1;

        for &num in nums.iter() {
            let k = num - 1;
            if !num_set.contains(&k) && k > max_k {
                max_k = k;
            }
        }

        max_k
    }
}