impl Solution {
    pub fn max_ascending_subarray_sum(nums: Vec<i32>) -> i32 {
        let mut max_sum = 0;
        let mut current_sum = nums[0];
        max_sum = current_sum;

        for i in 1..nums.len() {
            if nums[i] > nums[i - 1] {
                current_sum += nums[i];
            } else {
                current_sum = nums[i];
            }
            max_sum = max_sum.max(current_sum);
        }

        max_sum
    }
}