impl Solution {
    pub fn minimum_average(nums: Vec<i32>) -> f64 {
        let mut min_avg = f64::MAX;
        let mut max_val = i32::MIN;
        let mut min_val = i32::MAX;

        for &num in &nums {
            if num < min_val {
                min_val = num;
            }
            if num > max_val {
                max_val = num;
            }
        }

        min_avg = (min_val + max_val) as f64 / 2.0;
        min_avg
    }
}