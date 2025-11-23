impl Solution {
    pub fn first_day_been_in_all_rooms(next_visit: Vec<i32>) -> i32 {
        let n = next_visit.len();
        let mut dp = vec![0; n];
        let modulo = 1_000_000_007;

        for i in 0..(n - 1) {
            let j = next_visit[i] as usize;
            let diff = dp[i] - dp[j] + i as i32;
            let next_visit_day = if diff < 0 {
                (dp[i] + 1) % modulo
            } else {
                (dp[i] + 1 + diff) % modulo
            };
            dp[i + 1] = next_visit_day;
        }

        dp[n - 1]
    }
}