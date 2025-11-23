impl Solution {
    pub fn minimum_average_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let total_sum: i64 = nums.iter().map(|&x| x as i64).sum();
        let mut left_sum = 0;
        let mut min_avg_diff = i64::MAX;
        let mut result_index = -1;

        for i in 0..n {
            left_sum += nums[i] as i64;
            let left_avg = left_sum / (i as i64 + 1);
            let right_avg = if i == n - 1 { 0 } else { (total_sum - left_sum) / ((n - i - 1) as i64) };
            let diff = (left_avg - right_avg).abs();

            if diff < min_avg_diff {
                min_avg_diff = diff;
                result_index = i as i32;
            }
        }

        result_index
    }
}