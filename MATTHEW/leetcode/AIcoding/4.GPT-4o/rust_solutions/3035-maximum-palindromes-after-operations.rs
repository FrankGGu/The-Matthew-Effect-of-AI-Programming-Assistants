pub fn maximum_palindromes(s: String, k: usize) -> usize {
    let n = s.len();
    let mut dp = vec![0; n + 1];
    let mut count = vec![0; n + 1];

    for i in 0..n {
        let mut j = i;
        let mut l = 0;
        while j < n && s[i..=j] == s[i..=j].chars().rev().collect::<String>() {
            dp[j + 1] = dp[j] + 1;
            j += 1;
            l += 1;
        }
        count[l] += 1;
    }

    let mut ans = 0;
    for i in 0..=n {
        if dp[i] > 0 {
            ans += count[dp[i]];
        }
    }

    ans
}