impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn mark_elements(nums: Vec<i32>, change_indices: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;
        let mut marked = vec![false; n];
        let mut marked_count = 0;
        let mut result = Vec::with_capacity(n);
        let mut seen = HashSet::new();

        for i in 0..n {
            let idx = change_indices[i] as usize;
            if !marked[idx] {
                marked[idx] = true;
                marked_count += 1;
                if marked_count > k {
                    return vec![-1];
                }
                seen.insert(nums[idx]);
            }
            result.push(*seen.iter().max().unwrap());
        }

        result
    }
}
}