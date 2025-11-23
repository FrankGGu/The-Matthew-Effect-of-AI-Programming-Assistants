impl Solution {

use std::vec::Vec;

impl Solution {
    pub fn combination_sum_iii(mut k: i32, mut n: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut current = Vec::new();
        Self::backtrack(&mut result, &mut current, 1, k, n);
        result
    }

    fn backtrack(result: &mut Vec<Vec<i32>>, current: &mut Vec<i32>, start: i32, k: i32, target: i32) {
        if current.len() as i32 == k {
            if target == 0 {
                result.push(current.clone());
            }
            return;
        }

        for i in start..=9 {
            if i > target {
                break;
            }
            current.push(i);
            Self::backtrack(result, current, i + 1, k, target - i);
            current.pop();
        }
    }
}

pub struct Solution;
}