impl Solution {
    pub fn minimum_average_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0; 
        }

        let mut total_sum: i64 = 0;
        for &num in &nums {
            total_sum += num as i64;
        }

        let mut min_avg_diff: i64 = i64::MAX;
        let mut result_idx: i32 = 0;

        let mut current_left_sum: i64 = 0;

        for i in 0..n {
            current_left_sum += nums[i] as i64;

            let left_count = (i + 1) as i64;
            let left_avg = current_left_sum / left_count;

            let current_right_sum = total_sum - current_left_sum;
            let right_count = (n - (i + 1)) as i64;

            let right_avg = if right_count == 0 {
                0
            } else {
                current_right_sum / right_count
            };

            let current_avg_diff = (left_avg - right_avg).abs();

            if current_avg_diff < min_avg_diff {
                min_avg_diff = current_avg_diff;
                result_idx = i as i32;
            }
        }

        result_idx
    }
}