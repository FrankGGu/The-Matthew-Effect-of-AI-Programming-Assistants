impl Solution {
    pub fn permute(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut current_permutation = nums;
        Self::backtrack(&mut current_permutation, 0, &mut result);
        result
    }

    fn backtrack(nums: &mut Vec<i32>, start: usize, result: &mut Vec<Vec<i32>>) {
        if start == nums.len() {
            result.push(nums.to_vec());
            return;
        }

        for i in start..nums.len() {
            nums.swap(start, i);
            Self::backtrack(nums, start + 1, result);
            nums.swap(start, i); // Backtrack
        }
    }
}