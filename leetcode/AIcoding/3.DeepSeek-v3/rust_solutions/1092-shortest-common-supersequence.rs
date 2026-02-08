impl Solution {
    pub fn shortest_common_supersequence(str1: String, str2: String) -> String {
        let s1 = str1.as_bytes();
        let s2 = str2.as_bytes();
        let m = s1.len();
        let n = s2.len();
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in 0..=m {
            for j in 0..=n {
                if i == 0 {
                    dp[i][j] = j;
                } else if j == 0 {
                    dp[i][j] = i;
                } else if s1[i - 1] == s2[j - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1];
                } else {
                    dp[i][j] = 1 + std::cmp::min(dp[i - 1][j], dp[i][j - 1]);
                }
            }
        }

        let mut i = m;
        let mut j = n;
        let mut res = Vec::new();

        while i > 0 && j > 0 {
            if s1[i - 1] == s2[j - 1] {
                res.push(s1[i - 1]);
                i -= 1;
                j -= 1;
            } else if dp[i - 1][j] < dp[i][j - 1] {
                res.push(s1[i - 1]);
                i -= 1;
            } else {
                res.push(s2[j - 1]);
                j -= 1;
            }
        }

        while i > 0 {
            res.push(s1[i - 1]);
            i -= 1;
        }

        while j > 0 {
            res.push(s2[j - 1]);
            j -= 1;
        }

        res.reverse();
        String::from_utf8(res).unwrap()
    }
}