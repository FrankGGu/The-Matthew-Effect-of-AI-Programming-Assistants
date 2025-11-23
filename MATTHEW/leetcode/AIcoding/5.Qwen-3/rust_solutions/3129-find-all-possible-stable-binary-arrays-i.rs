impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_stable_binary_arrays(n: i32) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut result = Vec::new();
        let mut current = vec![0; n];
        Self::backtrack(&mut current, 0, &mut result);
        result
    }

    fn backtrack(current: &mut Vec<i32>, index: usize, result: &mut Vec<Vec<i32>>) {
        if index == current.len() {
            result.push(current.clone());
            return;
        }

        current[index] = 0;
        Self::backtrack(current, index + 1, result);

        if index == 0 || current[index - 1] != 1 {
            current[index] = 1;
            Self::backtrack(current, index + 1, result);
        }
    }
}
}