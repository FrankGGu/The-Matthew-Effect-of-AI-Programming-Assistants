impl Solution {
    pub fn get_sum_absolute_differences(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut prefix_sum = vec![0; n + 1];

        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        for i in 0..n {
            result[i] = (i as i32 * nums[i] - prefix_sum[i]) + (prefix_sum[n] - prefix_sum[i+1] - (n as i32 - i as i32 - 1) * nums[i]);
        }

        result
    }
}