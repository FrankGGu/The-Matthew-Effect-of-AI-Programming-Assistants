use std::collections::HashSet;

impl Solution {
    pub fn find_subsequences(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut res = HashSet::new();
        let mut current = Vec::new();
        Self::backtrack(&nums, &mut res, &mut current, 0);
        res.into_iter().collect()
    }

    fn backtrack(nums: &[i32], res: &mut HashSet<Vec<i32>>, current: &mut Vec<i32>, start: usize) {
        if current.len() >= 2 {
            res.insert(current.clone());
        }
        let mut used = HashSet::new();
        for i in start..nums.len() {
            if (current.is_empty() || nums[i] >= *current.last().unwrap()) && !used.contains(&nums[i]) {
                current.push(nums[i]);
                Self::backtrack(nums, res, current, i + 1);
                current.pop();
                used.insert(nums[i]);
            }
        }
    }
}