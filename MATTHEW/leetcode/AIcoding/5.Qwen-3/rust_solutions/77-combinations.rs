impl Solution {

use std::vec::Vec;

struct Solution {}

impl Solution {
    pub fn combine(n: i32, k: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut current = Vec::new();
        Self::backtrack(n, k, 1, &mut current, &mut result);
        result
    }

    fn backtrack(n: i32, k: i32, start: i32, current: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if current.len() as i32 == k {
            result.push(current.clone());
            return;
        }

        for i in start..=n {
            current.push(i);
            Self::backtrack(n, k, i + 1, current, result);
            current.pop();
        }
    }
}
}