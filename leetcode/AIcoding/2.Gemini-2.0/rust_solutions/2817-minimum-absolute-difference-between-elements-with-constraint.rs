impl Solution {
    pub fn min_absolute_difference(nums: Vec<i32>, x: i32) -> i32 {
        use std::collections::BTreeSet;
        let mut set = BTreeSet::new();
        let mut min_diff = i32::MAX;
        let x = x as usize;

        for i in x..nums.len() {
            set.insert(nums[i - x]);
            let num = nums[i];

            if let Some(&ceil) = set.range(num..).next() {
                min_diff = min_diff.min((ceil - num).abs());
            }

            if let Some(&floor) = set.range(..=num).next_back() {
                min_diff = min_diff.min((num - floor).abs());
            }
        }

        min_diff
    }
}