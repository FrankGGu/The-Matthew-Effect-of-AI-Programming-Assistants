impl Solution {
    pub fn minimum_average(nums: Vec<i32>) -> f64 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut min_avg = f64::MAX;
        for i in 0..n / 2 {
            let avg = (nums[i] + nums[n - 1 - i]) as f64 / 2.0;
            if avg < min_avg {
                min_avg = avg;
            }
        }
        min_avg
    }
}