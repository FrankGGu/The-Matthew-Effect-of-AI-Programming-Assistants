pub fn shortest_common_supersequence(str1: String, str2: String) -> String {
    let m = str1.len();
    let n = str2.len();
    let mut dp = vec![vec![0; n + 1]; m + 1];

    for i in 1..=m {
        for j in 1..=n {
            if str1.as_bytes()[i - 1] == str2.as_bytes()[j - 1] {
                dp[i][j] = dp[i - 1][j - 1] + 1;
            } else {
                dp[i][j] = dp[i - 1][j].max(dp[i][j - 1]);
            }
        }
    }

    let mut i = m;
    let mut j = n;
    let mut result = String::new();

    while i > 0 || j > 0 {
        if i > 0 && j > 0 && str1.as_bytes()[i - 1] == str2.as_bytes()[j - 1] {
            result.push(str1.as_bytes()[i - 1] as char);
            i -= 1;
            j -= 1;
        } else if j == 0 || (i > 0 && dp[i - 1][j] >= dp[i][j - 1]) {
            result.push(str1.as_bytes()[i - 1] as char);
            i -= 1;
        } else {
            result.push(str2.as_bytes()[j - 1] as char);
            j -= 1;
        }
    }

    result.chars().rev().collect()
}