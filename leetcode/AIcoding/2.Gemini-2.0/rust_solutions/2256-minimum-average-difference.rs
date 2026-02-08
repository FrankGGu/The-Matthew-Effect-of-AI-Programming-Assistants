impl Solution {
    pub fn minimum_average_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let mut min_avg_diff = i32::MAX;
        let mut min_index = 0;

        for i in 0..n {
            let avg1 = prefix_sum[i + 1] / (i as i64 + 1);
            let avg2 = if i == n - 1 {
                0
            } else {
                (prefix_sum[n] - prefix_sum[i + 1]) / (n as i64 - i as i64 - 1)
            };

            let diff = (avg1 - avg2).abs() as i32;

            if diff < min_avg_diff {
                min_avg_diff = diff;
                min_index = i as i32;
            }
        }

        min_index
    }
}