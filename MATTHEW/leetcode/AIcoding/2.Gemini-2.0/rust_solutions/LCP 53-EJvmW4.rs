impl Solution {
    pub fn defend_space_city(time: Vec<i32>, shield: Vec<i32>, power: i32) -> i64 {
        let n = time.len();
        let mut dp = vec![0; n + 1];
        for i in 1..=n {
            dp[i] = dp[i - 1] + shield[i - 1] as i64;
            let mut j = i - 1;
            let mut sum = 0;
            while j >= 1 && time[i - 1] - time[j - 1] < power {
                sum += shield[j - 1] as i64;
                j -= 1;
            }
            if j == 0 {
                sum += shield[0] as i64;
                dp[i] = dp[i].min(sum);
            } else {
                dp[i] = dp[i].min(dp[j - 1] + sum);
            }
        }
        dp[n]
    }
}