impl Solution {
    pub fn at_most_n_given_digit_set(digits: Vec<String>, n: i32) -> i32 {
        let s = n.to_string();
        let k = s.len();
        let digits: Vec<char> = digits.into_iter().map(|d| d.chars().next().unwrap()).collect();
        let mut dp = vec![0; k + 1];
        dp[k] = 1;

        for i in (0..k).rev() {
            let si = s.chars().nth(i).unwrap();
            for &d in &digits {
                if d < si {
                    dp[i] += digits.len().pow((k - i - 1) as u32);
                } else if d == si {
                    dp[i] += dp[i + 1];
                }
            }
        }

        let mut res = dp[0];
        for i in 1..k {
            res += digits.len().pow(i as u32);
        }

        res as i32
    }
}