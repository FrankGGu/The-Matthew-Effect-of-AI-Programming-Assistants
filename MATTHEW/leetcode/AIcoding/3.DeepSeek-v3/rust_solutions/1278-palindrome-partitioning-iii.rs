impl Solution {
    pub fn palindrome_partition(s: String, k: i32) -> i32 {
        let s = s.chars().collect::<Vec<char>>();
        let n = s.len();
        let k = k as usize;

        let mut cost = vec![vec![0; n]; n];
        for len in 2..=n {
            for i in 0..=n-len {
                let j = i + len - 1;
                cost[i][j] = cost[i+1][j-1] + if s[i] == s[j] { 0 } else { 1 };
            }
        }

        let mut dp = vec![vec![std::i32::MAX; k + 1]; n];
        for i in 0..n {
            dp[i][1] = cost[0][i];
            for l in 2..=k {
                if l > i + 1 {
                    continue;
                }
                for j in 0..i {
                    if dp[j][l-1] != std::i32::MAX {
                        dp[i][l] = dp[i][l].min(dp[j][l-1] + cost[j+1][i]);
                    }
                }
            }
        }

        dp[n-1][k]
    }
}