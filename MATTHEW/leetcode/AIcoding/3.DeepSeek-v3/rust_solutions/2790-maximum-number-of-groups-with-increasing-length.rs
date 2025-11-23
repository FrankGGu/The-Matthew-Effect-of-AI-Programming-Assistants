impl Solution {
    pub fn max_increasing_groups(usage_limits: Vec<i32>) -> i32 {
        let mut limits = usage_limits;
        limits.sort();
        let mut total = 0i64;
        let mut k = 0i64;
        for (i, &limit) in limits.iter().enumerate() {
            total += limit as i64;
            if total >= (k + 1) * (k + 2) / 2 {
                k += 1;
            }
        }
        k as i32
    }
}