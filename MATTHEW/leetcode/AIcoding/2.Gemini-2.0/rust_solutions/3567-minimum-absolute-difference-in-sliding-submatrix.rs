use std::cmp::{max, min};
use std::collections::BTreeSet;

impl Solution {
    pub fn min_difference(mat: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = mat.len();
        let mut min_diff = i32::MAX;

        for i in 0..=(n - k as usize) {
            for j in 0..=(n - k as usize) {
                let mut nums = Vec::new();
                for row in i..(i + k as usize) {
                    for col in j..(j + k as usize) {
                        nums.push(mat[row][col]);
                    }
                }

                nums.sort();

                for l in 0..(nums.len() - 1) {
                    min_diff = min(min_diff, (nums[l] - nums[l + 1]).abs());
                }
            }
        }

        min_diff
    }
}