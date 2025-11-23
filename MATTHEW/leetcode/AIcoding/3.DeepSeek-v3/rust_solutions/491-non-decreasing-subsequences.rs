impl Solution {
    pub fn find_subsequences(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut path = Vec::new();
        Self::backtrack(&nums, 0, &mut path, &mut result);
        result
    }

    fn backtrack(nums: &[i32], start: usize, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if path.len() >= 2 {
            result.push(path.clone());
        }
        let mut used = std::collections::HashSet::new();
        for i in start..nums.len() {
            if used.contains(&nums[i]) {
                continue;
            }
            if path.is_empty() || nums[i] >= *path.last().unwrap() {
                used.insert(nums[i]);
                path.push(nums[i]);
                Self::backtrack(nums, i + 1, path, result);
                path.pop();
            }
        }
    }
}