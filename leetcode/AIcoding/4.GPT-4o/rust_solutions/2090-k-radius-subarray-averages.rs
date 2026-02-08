impl Solution {
    pub fn get_averages(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;
        let mut result = vec![-1; n];
        let mut sum = 0;

        if n < 2 * k + 1 {
            return result;
        }

        for i in 0..2 * k {
            sum += nums[i];
        }

        for i in k..n - k {
            sum += nums[i + k];
            result[i] = sum / (2 * k + 1) as i32;
            sum -= nums[i - k];
        }

        result
    }
}