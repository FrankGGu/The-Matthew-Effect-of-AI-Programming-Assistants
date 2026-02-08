struct Solution;

impl Solution {
    pub fn permute_unique(mut nums: Vec<i32>) -> Vec<Vec<i32>> {
        nums.sort_unstable();
        let mut result = Vec::new();
        let mut current_permutation = Vec::new();
        let mut visited = vec![false; nums.len()];
        Self::backtrack(&nums, &mut visited, &mut current_permutation, &mut result);
        result
    }

    fn backtrack(
        nums: &[i32],
        visited: &mut Vec<bool>,
        current_permutation: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        if current_permutation.len() == nums.len() {
            result.push(current_permutation.clone());
            return;
        }

        for i in 0..nums.len() {
            if visited[i] {
                continue;
            }
            if i > 0 && nums[i] == nums[i - 1] && !visited[i - 1] {
                continue;
            }

            visited[i] = true;
            current_permutation.push(nums[i]);
            Self::backtrack(nums, visited, current_permutation, result);
            current_permutation.pop();
            visited[i] = false;
        }
    }
}