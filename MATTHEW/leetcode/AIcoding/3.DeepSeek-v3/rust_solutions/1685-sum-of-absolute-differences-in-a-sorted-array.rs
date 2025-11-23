impl Solution {
    pub fn get_sum_absolute_differences(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        let mut res = vec![0; n];
        for i in 0..n {
            let left_sum = nums[i] * i as i32 - prefix[i];
            let right_sum = (prefix[n] - prefix[i + 1]) - nums[i] * (n - i - 1) as i32;
            res[i] = left_sum + right_sum;
        }
        res
    }
}