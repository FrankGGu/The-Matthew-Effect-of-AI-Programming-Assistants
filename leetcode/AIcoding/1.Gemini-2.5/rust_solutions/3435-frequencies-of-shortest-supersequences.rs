impl Solution {
    pub fn shortest_common_supersequence_frequencies(str1: String, str2: String) -> i32 {
        let n = str1.len();
        let m = str2.len();
        let s1_chars: Vec<char> = str1.chars().collect();
        let s2_chars: Vec<char> = str2.chars().collect();

        let mut dp = vec![vec![0; m + 1]; n + 1];
        let mut count = vec![vec![0; m + 1]; n + 1];
        let modulo = 1_000_000_007;

        dp[0][0] = 0;
        count[0][0] = 1;

        for i in 1..=n {
            dp[i][0] = i as i32;
            count[i][0] = 1;
        }
        for j in 1..=m {
            dp[0][j] = j as i32;
            count[0][j] = 1;
        }

        for i in 1..=n {
            for j in 1..=m {
                if s1_chars[i - 1] == s2_chars[j - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1];
                    count[i][j] = count[i - 1][j - 1];
                } else {
                    let len1 = 1 + dp[i - 1][j];
                    let len2 = 1 + dp[i][j - 1];

                    if len1 < len2 {
                        dp[i][j] = len1;
                        count[i][j] = count[i - 1][j];
                    } else if len2 < len1 {
                        dp[i][j] = len2;
                        count[i][j] = count[i][j - 1];
                    } else {
                        dp[i][j] = len1;
                        count[i][j] = (count[i - 1][j] + count[i][j - 1]) % modulo;
                    }
                }
            }
        }

        count[n][m]
    }
}