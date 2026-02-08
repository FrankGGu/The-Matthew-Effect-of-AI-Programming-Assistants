use std::collections::BTreeSet;

impl Solution {
    pub fn min_absolute_difference(nums: Vec<i32>, x: i32) -> i32 {
        let x = x as usize;
        let mut bst = BTreeSet::new();
        let mut min_diff = i32::MAX;

        for i in x..nums.len() {
            bst.insert(nums[i - x]);
            let current = nums[i];

            if let Some(&floor) = bst.range(..=current).next_back() {
                min_diff = min_diff.min(current - floor);
            }
            if let Some(&ceiling) = bst.range(current..).next() {
                min_diff = min_diff.min(ceiling - current);
            }
        }

        min_diff
    }
}