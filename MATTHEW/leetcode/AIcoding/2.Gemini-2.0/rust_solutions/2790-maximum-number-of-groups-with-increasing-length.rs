impl Solution {
    pub fn max_increasing_groups(mut usage_limits: Vec<i32>) -> i32 {
        usage_limits.sort();
        let mut total_sum: i64 = 0;
        let mut count: i32 = 0;
        for &limit in &usage_limits {
            total_sum += limit as i64;
            if total_sum >= (count as i64 + 1) * (count as i64 + 2) / 2 {
                count += 1;
            }
        }
        count
    }
}