impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn target_indices(mut nums: Vec<i32>, target: i32) -> Vec<i32> {
        nums.sort();
        let mut result = Vec::new();
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;

        while left <= right {
            let mid = (left + right) / 2;
            match nums[mid as usize].cmp(&target) {
                Ordering::Less => left = mid + 1,
                Ordering::Greater => right = mid - 1,
                Ordering::Equal => {
                    let mut i = mid;
                    while i >= 0 && nums[i as usize] == target {
                        i -= 1;
                    }
                    i += 1;
                    while i < nums.len() as i32 && nums[i as usize] == target {
                        result.push(i);
                        i += 1;
                    }
                    break;
                }
            }
        }

        result
    }
}
}