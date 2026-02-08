impl Solution {
    pub fn find_max_average(nums: Vec<i32>, k: i32) -> f64 {
        let k = k as usize;
        let mut current_sum: i32 = nums[0..k].iter().sum();
        let mut max_sum: i32 = current_sum;

        for i in k..nums.len() {
            current_sum += nums[i] - nums[i - k];
            if current_sum > max_sum {
                max_sum = current_sum;
            }
        }

        max_sum as f64 / k as f64
    }
}