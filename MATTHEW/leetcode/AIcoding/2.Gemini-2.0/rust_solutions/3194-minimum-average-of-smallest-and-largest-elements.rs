impl Solution {
    pub fn minimum_average(nums: Vec<i32>) -> f64 {
        let n = nums.len();
        let mut min_avg = f64::MAX;

        for k in 1..=n {
            let mut sum = 0;
            let mut temp = nums.clone();
            temp.sort();

            for i in 0..k {
                sum += temp[i];
            }
            for i in (n - k)..n {
                sum += temp[i];
            }

            let avg = sum as f64 / (2 * k) as f64;
            min_avg = min_avg.min(avg);
        }

        min_avg
    }
}