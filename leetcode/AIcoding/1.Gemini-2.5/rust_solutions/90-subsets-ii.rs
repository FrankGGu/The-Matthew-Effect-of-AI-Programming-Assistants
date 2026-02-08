impl Solution {
    pub fn subsets_with_dup(mut nums: Vec<i32>) -> Vec<Vec<i32>> {
        nums.sort_unstable();
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_subset: Vec<i32> = Vec::new();

        Self::backtrack(&nums, 0, &mut current_subset, &mut result);

        result
    }

    fn backtrack(
        nums: &[i32],
        start_index: usize,
        current_subset: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        result.push(current_subset.clone());

        for i in start_index..nums.len() {
            if i > start_index && nums[i] == nums[i - 1] {
                continue;
            }

            current_subset.push(nums[i]);
            Self::backtrack(nums, i + 1, current_subset, result);
            current_subset.pop();
        }
    }
}