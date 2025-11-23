impl Solution {
    pub fn max_sub_array(nums: Vec<i32>) -> i32 {
        let mut max_sum = nums[0];
        let mut current_sum = nums[0];

        for &num in &nums[1..] {
            current_sum = current_sum.max(num + current_sum);
            max_sum = max_sum.max(current_sum);
        }

        max_sum
    }
}