impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_max_concave(sizes: Vec<Vec<char>>, m: i32, n: i32) -> i32 {
        let mut dp = vec![vec![0; n as usize + 1]; m as usize + 1];

        for size in sizes {
            let (zeros, ones) = count_zeros_ones(&size);
            for i in (0..=m as usize).rev() {
                for j in (0..=n as usize).rev() {
                    if i >= zeros && j >= ones {
                        dp[i][j] = dp[i][j].max(dp[i - zeros][j - ones] + 1);
                    }
                }
            }
        }

        dp[m as usize][n as usize]
    }
}

fn count_zeros_ones(s: &[char]) -> (usize, usize) {
    let mut zeros = 0;
    let mut ones = 0;
    for c in s {
        if *c == '0' {
            zeros += 1;
        } else {
            ones += 1;
        }
    }
    (zeros, ones)
}

struct Solution {}
}