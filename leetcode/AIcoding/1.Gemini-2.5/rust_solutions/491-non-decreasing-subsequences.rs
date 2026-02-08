use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn find_subsequences(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result_set: HashSet<Vec<i32>> = HashSet::new();
        let mut current_subsequence: Vec<i32> = Vec::new();

        Self::backtrack(0, &nums, &mut current_subsequence, &mut result_set);

        result_set.into_iter().collect()
    }

    fn backtrack(
        start_index: usize,
        nums: &[i32],
        current_subsequence: &mut Vec<i32>,
        result_set: &mut HashSet<Vec<i32>>,
    ) {
        if current_subsequence.len() >= 2 {
            result_set.insert(current_subsequence.clone());
        }

        for i in start_index..nums.len() {
            if current_subsequence.is_empty() || nums[i] >= *current_subsequence.last().unwrap() {
                current_subsequence.push(nums[i]);
                Self::backtrack(i + 1, nums, current_subsequence, result_set);
                current_subsequence.pop();
            }
        }
    }
}