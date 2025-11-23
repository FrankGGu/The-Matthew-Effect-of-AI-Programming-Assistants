impl Solution {
    pub fn is_scramble(s1: String, s2: String) -> bool {
        let n = s1.len();
        if n != s2.len() {
            return false;
        }
        if s1 == s2 {
            return true;
        }

        let mut count = vec![0; 26];
        for (c1, c2) in s1.chars().zip(s2.chars()) {
            count[c1 as usize - 'a' as usize] += 1;
            count[c2 as usize - 'a' as usize] -= 1;
        }

        if count.iter().any(|&x| x != 0) {
            return false;
        }

        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let mut dp = vec![vec![vec![false; n]; n]; n + 1];

        for i in 1..=n {
            for j in 0..=n - i {
                for k in 0..=n - i {
                    if s1_bytes[j..j + i].iter().zip(&s2_bytes[k..k + i]).all(|(&x, &y)| x == y) {
                        dp[i][j][k] = true;
                    }
                }
            }
        }

        for len in 1..=n {
            for i in 0..=n - len {
                for j in 0..=n - len {
                    for k in 1..len {
                        if (dp[k][i][j] && dp[len - k][i + k][j + k]) || 
                           (dp[k][i][j + len - k] && dp[len - k][i + k][j]) {
                            dp[len][i][j] = true;
                            break;
                        }
                    }
                }
            }
        }

        dp[n][0][0]
    }
}