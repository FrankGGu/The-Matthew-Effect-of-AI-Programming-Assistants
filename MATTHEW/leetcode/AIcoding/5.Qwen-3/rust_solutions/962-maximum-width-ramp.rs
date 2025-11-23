impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_width_ramp(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut indices = (0..n).collect::<Vec<_>>();

        indices.sort_by(|&i, &j| match nums[i].cmp(&nums[j]) {
            Ordering::Equal => i.cmp(&j),
            other => other,
        });

        let mut max_width = 0;
        let mut min_index = n;

        for &i in &indices {
            if i < min_index {
                min_index = i;
            } else {
                max_width = max_width.max(i - min_index);
            }
        }

        max_width as i32
    }
}
}