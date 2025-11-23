impl Solution {
    pub fn shortest_common_supersequence(str1: String, str2: String) -> String {
        let s1 = str1.as_bytes();
        let s2 = str2.as_bytes();
        let m = s1.len();
        let n = s2.len();

        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                if s1[i - 1] == s2[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1;
                } else {
                    dp[i][j] = std::cmp::max(dp[i - 1][j], dp[i][j - 1]);
                }
            }
        }

        let mut i = m;
        let mut j = n;
        let mut result = String::new();

        while i > 0 || j > 0 {
            if i > 0 && j > 0 && s1[i - 1] == s2[j - 1] {
                result.push(s1[i - 1] as char);
                i -= 1;
                j -= 1;
            } else if i > 0 && (j == 0 || dp[i - 1][j] >= dp[i][j - 1]) {
                result.push(s1[i - 1] as char);
                i -= 1;
            } else {
                result.push(s2[j - 1] as char);
                j -= 1;
            }
        }

        result.chars().rev().collect()
    }
}