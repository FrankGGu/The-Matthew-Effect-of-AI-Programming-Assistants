impl Solution {
    pub fn get_sum_absolute_differences(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut prefix_sum = vec![0; n + 1];

        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        for i in 0..n {
            left_sum = nums[i] * (i as i32) - prefix_sum[i];
            right_sum = (prefix_sum[n] - prefix_sum[i + 1]) - nums[i] * (n as i32 - i as i32 - 1);
            result[i] = left_sum + right_sum;
        }

        result
    }
}