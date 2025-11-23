impl Solution {
    pub fn minimum_average_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let total_sum = prefix_sum[n];
        let mut min_avg_diff = i64::MAX;
        let mut result = 0;

        for i in 0..n {
            let left_sum = prefix_sum[i + 1];
            let left_count = (i + 1) as i64;
            let left_avg = left_sum / left_count;

            let right_sum = total_sum - left_sum;
            let right_count = if i == n - 1 { 1 } else { (n - i - 1) as i64 };
            let right_avg = if right_count == 0 { 0 } else { right_sum / right_count };

            let avg_diff = (left_avg - right_avg).abs();

            if avg_diff < min_avg_diff {
                min_avg_diff = avg_diff;
                result = i as i32;
            }
        }

        result
    }
}