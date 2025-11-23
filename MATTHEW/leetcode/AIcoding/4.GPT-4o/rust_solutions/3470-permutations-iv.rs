use std::collections::HashSet;

impl Solution {
    pub fn permute_unique(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = vec![];
        let mut nums = nums;
        nums.sort();
        Self::backtrack(&mut result, &mut vec![], &mut vec![false; nums.len()], &nums);
        result
    }

    fn backtrack(result: &mut Vec<Vec<i32>>, path: &mut Vec<i32>, used: &mut Vec<bool>, nums: &Vec<i32>) {
        if path.len() == nums.len() {
            result.push(path.clone());
            return;
        }

        let mut seen = HashSet::new();
        for i in 0..nums.len() {
            if used[i] || seen.contains(&nums[i]) {
                continue;
            }
            seen.insert(nums[i]);
            used[i] = true;
            path.push(nums[i]);
            Self::backtrack(result, path, used, nums);
            path.pop();
            used[i] = false;
        }
    }
}