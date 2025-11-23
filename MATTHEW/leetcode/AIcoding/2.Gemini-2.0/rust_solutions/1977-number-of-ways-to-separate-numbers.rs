impl Solution {
    pub fn number_of_ways(s: String) -> i32 {
        let n = s.len();
        let s: Vec<u8> = s.bytes().collect();
        let modulo = 1_000_000_007;
        let mut dp = vec![0; n + 1];
        dp[0] = 1;

        for i in 1..=n {
            for j in 1..=i {
                if s[i - j] == b'0' {
                    continue;
                }

                if j > i - j {
                    dp[i] = (dp[i] + dp[i - j]) % modulo;
                } else if j == i - j {
                    dp[i] = (dp[i] + dp[i - j]) % modulo;
                } else {
                    let mut valid = true;
                    for k in 0..j {
                        if s[i - j + k] > s[i - 2 * j + k] {
                            valid = true;
                            break;
                        } else if s[i - j + k] < s[i - 2 * j + k] {
                            valid = false;
                            break;
                        } else {
                            valid = false;
                        }
                    }

                    if valid {
                        dp[i] = (dp[i] + dp[i - j]) % modulo;
                    } else if !valid {
                        let mut are_equal = true;
                        for k in 0..j{
                            if s[i - j + k] != s[i - 2 * j + k] {
                                are_equal = false;
                                break;
                            }
                        }
                        if are_equal {
                            dp[i] = (dp[i] + dp[i - j]) % modulo;
                        }
                    }
                }
            }
        }

        dp[n] as i32
    }
}