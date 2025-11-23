impl Solution {
    pub fn get_sum_absolute_differences(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];

        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        let total_sum = prefix_sum[n];

        for i in 0..n {
            let left_sum = prefix_sum[i];
            let right_sum = total_sum - prefix_sum[i + 1];

            let left_count = i as i32;
            let right_count = (n - 1 - i) as i32;

            let left_diff_sum = nums[i] * left_count - left_sum;
            let right_diff_sum = right_sum - nums[i] * right_count;

            result[i] = left_diff_sum + right_diff_sum;
        }

        result
    }
}