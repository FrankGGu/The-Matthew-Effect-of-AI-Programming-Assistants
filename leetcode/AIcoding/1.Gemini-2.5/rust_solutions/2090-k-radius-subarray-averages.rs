impl Solution {
    pub fn get_averages(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k_usize = k as usize;
        let window_size = 2 * k_usize + 1;

        let mut ans = vec![-1; n];

        if window_size > n {
            return ans;
        }

        let mut current_sum: i64 = 0;

        for i in 0..window_size {
            current_sum += nums[i] as i64;
        }
        ans[k_usize] = (current_sum / window_size as i64) as i32;

        for i in (k_usize + 1)..(n - k_usize) {
            current_sum -= nums[i - k_usize - 1] as i64;
            current_sum += nums[i + k_usize] as i64;
            ans[i] = (current_sum / window_size as i64) as i32;
        }

        ans
    }
}