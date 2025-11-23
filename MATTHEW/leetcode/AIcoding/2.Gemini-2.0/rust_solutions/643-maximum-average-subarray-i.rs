impl Solution {
    pub fn find_max_average(nums: Vec<i32>, k: i32) -> f64 {
        let k = k as usize;
        let mut sum: i64 = nums[..k].iter().map(|&x| x as i64).sum();
        let mut max_sum = sum;

        for i in k..nums.len() {
            sum += nums[i] as i64 - nums[i - k] as i64;
            max_sum = max_sum.max(sum);
        }

        max_sum as f64 / k as f64
    }
}