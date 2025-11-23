impl Solution {
    pub fn get_averages(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;
        let mut averages = vec![-1; n];

        if n < 2 * k + 1 {
            return averages;
        }

        let mut window_sum: i64 = 0;
        for i in 0..2 * k + 1 {
            window_sum += nums[i] as i64;
        }

        averages[k] = (window_sum / (2 * k + 1) as i64) as i32;

        for i in k + 1..n - k {
            window_sum -= nums[i - k - 1] as i64;
            window_sum += nums[i + k] as i64;
            averages[i] = (window_sum / (2 * k + 1) as i64) as i32;
        }

        averages
    }
}