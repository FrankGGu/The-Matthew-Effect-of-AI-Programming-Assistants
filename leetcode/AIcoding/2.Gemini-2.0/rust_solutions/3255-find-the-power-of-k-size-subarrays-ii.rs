impl Solution {
    pub fn find_the_value_of_k_subarray(nums: Vec<i32>, k: i32) -> f64 {
        let n = nums.len();
        let k = k as usize;

        if n < k {
            return 0.0;
        }

        let mut sum: i64 = 0;
        for i in 0..k {
            sum += nums[i] as i64;
        }

        let mut max_sum = sum;

        for i in k..n {
            sum += nums[i] as i64;
            sum -= nums[i - k] as i64;
            max_sum = max_sum.max(sum);
        }

        max_sum as f64 / k as f64
    }
}