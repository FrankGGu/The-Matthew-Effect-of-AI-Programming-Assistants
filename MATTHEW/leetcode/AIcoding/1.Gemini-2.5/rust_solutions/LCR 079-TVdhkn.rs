impl Solution {
    pub fn subsets(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_subset: Vec<i32> = Vec::new();

        Self::backtrack(0, &nums, &mut current_subset, &mut result);

        result
    }

    fn backtrack(
        start_index: usize,
        nums: &Vec<i32>,
        current_subset: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        result.push(current_subset.clone());

        for i in start_index..nums.len() {
            current_subset.push(nums[i]);
            Self::backtrack(i + 1, nums, current_subset, result);
            current_subset.pop();
        }
    }
}