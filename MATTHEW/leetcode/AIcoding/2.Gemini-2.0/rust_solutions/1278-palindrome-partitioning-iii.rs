impl Solution {
    pub fn palindrome_partition(s: String, k: i32) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();

        let mut cost = vec![vec![0; n]; n];
        for i in 0..n {
            for j in i + 1..n {
                let mut count = 0;
                let mut l = i;
                let mut r = j;
                while l < r {
                    if s[l] != s[r] {
                        count += 1;
                    }
                    l += 1;
                    r -= 1;
                }
                cost[i][j] = count;
            }
        }

        let mut dp = vec![vec![i32::MAX; k as usize + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 1..=k as usize {
                for l in 1..=i {
                    if dp[l - 1][j - 1] != i32::MAX {
                        dp[i][j] = dp[i][j].min(dp[l - 1][j - 1] + cost[l - 1][i - 1]);
                    }
                }
            }
        }

        dp[n][k as usize]
    }
}