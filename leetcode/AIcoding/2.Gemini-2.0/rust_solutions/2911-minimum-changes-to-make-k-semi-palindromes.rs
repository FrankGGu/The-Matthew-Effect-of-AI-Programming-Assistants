impl Solution {
    pub fn k_semi_palindromes(s: String, k: i32) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();

        let mut cost = vec![vec![0; n]; n];
        for i in 0..n {
            for j in i + 1..n {
                let mut l = i;
                let mut r = j;
                while l < r {
                    if s[l] != s[r] {
                        cost[i][j] += 1;
                    }
                    l += 1;
                    r -= 1;
                }
            }
        }

        let k = k as usize;
        let mut dp = vec![vec![i32::MAX; k + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 1..=k.min(i) {
                for l in 0..i {
                    if dp[l][j - 1] != i32::MAX {
                        dp[i][j] = dp[i][j].min(dp[l][j - 1] + cost[l][i - 1]);
                    }
                }
            }
        }

        dp[n][k]
    }
}