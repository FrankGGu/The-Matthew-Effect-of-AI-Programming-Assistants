impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn longest_binary_subsequence_less_than_or_equal_to_k(num: String, k: i32) -> i32 {
        let num_bytes = num.as_bytes();
        let k_bytes = k.to_string().as_bytes();
        let n = num_bytes.len();
        let m = k_bytes.len();

        if n < m {
            return n as i32;
        }

        if n > m {
            return -1;
        }

        let mut dp = vec![vec![0; 2]; n + 1];
        for i in 0..n {
            dp[i + 1][0] = dp[i][0] + (num_bytes[i] == b'0' || num_bytes[i] == b'1');
            dp[i + 1][1] = dp[i][1] + (num_bytes[i] == b'0' || num_bytes[i] == b'1');
        }

        for i in 0..n {
            for j in 0..2 {
                if num_bytes[i] == b'0' {
                    dp[i + 1][j] = dp[i][j];
                } else {
                    dp[i + 1][j] = dp[i][j] + 1;
                }
            }
        }

        for i in 0..n {
            for j in 0..2 {
                if num_bytes[i] == b'0' {
                    dp[i + 1][j] = dp[i][j];
                } else {
                    dp[i + 1][j] = dp[i][j] + 1;
                }
            }
        }

        let mut res = 0;
        for i in 0..n {
            let mut cnt = 0;
            let mut curr = 0;
            for j in 0..i {
                if num_bytes[j] == b'0' {
                    cnt += 1;
                } else {
                    curr = curr * 2 + 1;
                }
            }
            for j in i..n {
                if num_bytes[j] == b'0' {
                    cnt += 1;
                } else {
                    curr = curr * 2 + 1;
                }
                if curr > k {
                    break;
                }
                res = res.max(cnt);
            }
        }

        res
    }
}
}