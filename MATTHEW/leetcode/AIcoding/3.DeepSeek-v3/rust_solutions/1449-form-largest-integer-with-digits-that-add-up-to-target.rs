impl Solution {
    pub fn largest_number(cost: Vec<i32>, target: i32) -> String {
        let target = target as usize;
        let mut dp = vec![-1; target + 1];
        dp[0] = 0;
        for i in 1..=target {
            for &c in cost.iter() {
                let c = c as usize;
                if i >= c && dp[i - c] != -1 {
                    dp[i] = dp[i].max(dp[i - c] + 1);
                }
            }
        }
        if dp[target] == -1 {
            return "0".to_string();
        }
        let mut res = String::new();
        let mut remaining = target;
        for i in (0..9).rev() {
            let c = cost[i] as usize;
            while remaining >= c && dp[remaining] == dp[remaining - c] + 1 {
                res.push((b'1' + i as u8) as char);
                remaining -= c;
            }
        }
        res
    }
}