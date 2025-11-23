impl Solution {
    pub fn find_max_average(nums: Vec<i32>, k: usize) -> f64 {
        let sum: i32 = nums.iter().take(k).sum();
        let mut max_sum = sum;
        let mut current_sum = sum;

        for i in k..nums.len() {
            current_sum += nums[i] - nums[i - k];
            max_sum = max_sum.max(current_sum);
        }

        max_sum as f64 / k as f64
    }
}