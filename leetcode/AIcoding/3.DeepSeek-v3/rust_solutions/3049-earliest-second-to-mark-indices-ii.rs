use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn earliest_second_to_mark_indices(nums: Vec<i32>, change_indices: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = change_indices.len();
        let mut left = 1;
        let mut right = m as i32;
        let mut answer = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            if Self::is_possible(&nums, &change_indices, mid) {
                answer = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        answer
    }

    fn is_possible(nums: &[i32], change_indices: &[i32], s: i32) -> bool {
        let n = nums.len();
        let s = s as usize;
        let mut last_occurrence = vec![-1; n];
        for (i, &idx) in change_indices[..s].iter().enumerate() {
            let idx = idx as usize - 1;
            last_occurrence[idx] = i as i32;
        }

        for &occur in &last_occurrence {
            if occur == -1 {
                return false;
            }
        }

        let mut marked = 0;
        let mut time_used = 0;
        for (i, &idx) in change_indices[..s].iter().enumerate() {
            let idx = idx as usize - 1;
            if last_occurrence[idx] == i as i32 {
                if time_used >= nums[idx] as usize {
                    time_used -= nums[idx] as usize;
                    marked += 1;
                } else {
                    return false;
                }
            } else {
                time_used += 1;
            }
        }

        marked == n
    }
}