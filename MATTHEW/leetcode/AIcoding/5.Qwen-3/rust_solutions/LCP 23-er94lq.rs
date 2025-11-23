impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn magical_permutation(n: i32) -> Vec<i32> {
        let n = n as usize;
        let mut result = vec![0; n];
        let mut used = vec![false; n];

        fn backtrack(
            n: usize,
            used: &mut Vec<bool>,
            result: &mut Vec<i32>,
            index: usize,
            path: &mut Vec<i32>,
        ) -> bool {
            if index == n {
                *result = path.clone();
                return true;
            }

            for i in 0..n {
                if !used[i] && (index == 0 || (path[index - 1] + i as i32) % n == index as i32) {
                    used[i] = true;
                    path.push(i as i32);
                    if backtrack(n, used, result, index + 1, path) {
                        return true;
                    }
                    path.pop();
                    used[i] = false;
                }
            }

            false
        }

        let mut path = Vec::new();
        backtrack(n, &mut used, &mut result, 0, &mut path);
        result
    }
}
}