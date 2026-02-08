impl Solution {
    pub fn distribute_candies(n: i32, limit: i32) -> i64 {
        let mut res = 0i64;
        for a in 0..=limit {
            if a > n {
                break;
            }
            let remaining = n - a;
            let min_b = std::cmp::max(0, remaining - limit);
            let max_b = std::cmp::min(limit, remaining);
            if min_b > max_b {
                continue;
            }
            res += (max_b - min_b + 1) as i64;
        }
        res
    }
}