impl Solution {
    pub fn minimum_average(mut nums: Vec<i32>) -> f64 {
        nums.sort();
        let n = nums.len();
        let mut min_avg = f64::MAX;

        for i in 0..n / 2 {
            let current_sum = nums[i] + nums[n - 1 - i];
            let current_avg = current_sum as f64 / 2.0;
            if current_avg < min_avg {
                min_avg = current_avg;
            }
        }

        min_avg
    }
}