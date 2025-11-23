impl Solution {
    pub fn first_day_all_rooms(next_visit: Vec<i32>) -> i32 {
        let n = next_visit.len();
        let mut dp = vec![0; n];
        let mod_val = 1_000_000_007;

        for i in 1..n {
            dp[i] = (2 * dp[i - 1] - dp[next_visit[i - 1] as usize] + 2 + mod_val) % mod_val;
        }

        dp[n - 1]
    }
}