impl Solution {
    pub fn max_score(intervals: Vec<Vec<i32>>> -> i64 {
        let mut intervals = intervals;
        intervals.sort_by_key(|x| x[1]);
        let mut dp = vec![0; intervals.len() + 1];
        for i in 1..=intervals.len() {
            let current = &intervals[i - 1];
            let score = current[2] as i64;
            let mut prev_index = 0;
            for j in 0..i - 1 {
                if intervals[j][1] <= current[0] {
                    prev_index = (j + 1) as usize;
                } else {
                    break;
                }
            }
            dp[i] = dp[i - 1].max(dp[prev_index] + score);
        }
        dp[intervals.len()]
    }
}