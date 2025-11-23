impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn permute_unique(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut used = vec![false; nums.len()];
        let mut path = Vec::new();
        Self::backtrack(&nums, &mut used, &mut path, &mut result);
        result
    }

    fn backtrack(nums: &[i32], used: &mut Vec<bool>, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if path.len() == nums.len() {
            result.push(path.clone());
            return;
        }

        let mut seen = HashSet::new();

        for i in 0..nums.len() {
            if used[i] {
                continue;
            }

            if seen.contains(&nums[i]) {
                continue;
            }

            seen.insert(nums[i]);
            used[i] = true;
            path.push(nums[i]);
            Self::backtrack(nums, used, path, result);
            path.pop();
            used[i] = false;
        }
    }
}
}