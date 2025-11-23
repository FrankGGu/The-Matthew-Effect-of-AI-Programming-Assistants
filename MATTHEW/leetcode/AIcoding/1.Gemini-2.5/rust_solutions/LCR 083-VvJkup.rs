struct Solution;

impl Solution {
    pub fn permute(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_permutation: Vec<i32> = Vec::new();
        let mut used: Vec<bool> = vec![false; nums.len()];

        Self::backtrack(&nums, &mut used, &mut current_permutation, &mut result);

        result
    }

    fn backtrack(
        nums: &Vec<i32>,
        used: &mut Vec<bool>,
        current_permutation: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        if current_permutation.len() == nums.len() {
            result.push(current_permutation.clone());
            return;
        }

        for i in 0..nums.len() {
            if !used[i] {
                used[i] = true;
                current_permutation.push(nums[i]);

                Self::backtrack(nums, used, current_permutation, result);

                current_permutation.pop();
                used[i] = false;
            }
        }
    }
}