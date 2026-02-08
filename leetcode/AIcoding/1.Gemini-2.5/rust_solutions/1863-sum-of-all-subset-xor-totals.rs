impl Solution {
    pub fn subset_xor_sum(nums: Vec<i32>) -> i32 {
        let mut total_xor_sum = 0;
        Self::backtrack(0, 0, &nums, &mut total_xor_sum);
        total_xor_sum
    }

    fn backtrack(index: usize, current_xor: i32, nums: &[i32], total_sum: &mut i32) {
        if index == nums.len() {
            *total_sum += current_xor;
            return;
        }

        // Exclude the current element
        Self::backtrack(index + 1, current_xor, nums, total_sum);

        // Include the current element
        Self::backtrack(index + 1, current_xor ^ nums[index], nums, total_sum);
    }
}