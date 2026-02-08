impl Solution {
    pub fn permute_unique(mut nums: Vec<i32>) -> Vec<Vec<i32>> {
        nums.sort_unstable();
        let mut result = Vec::new();
        let mut current_permutation = Vec::new();
        let mut used = vec![false; nums.len()];
        Self::backtrack(&nums, &mut current_permutation, &mut used, &mut result);
        result
    }

    fn backtrack(
        nums: &[i32],
        current_permutation: &mut Vec<i32>,
        used: &mut Vec<bool>,
        result: &mut Vec<Vec<i32>>,
    ) {
        if current_permutation.len() == nums.len() {
            result.push(current_permutation.clone());
            return;
        }

        for i in 0..nums.len() {
            if used[i] {
                continue;
            }

            if i > 0 && nums[i] == nums[i - 1] && !used[i - 1] {
                continue;
            }

            current_permutation.push(nums[i]);
            used[i] = true;

            Self::backtrack(nums, current_permutation, used, result);

            used[i] = false;
            current_permutation.pop();
        }
    }
}