impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_jumps(mut arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut dp = vec![0; n];

        for i in 1..n {
            for j in 0..i {
                if (arr[i] as i32 - arr[j] as i32).abs() >= 2 {
                    match arr[i].cmp(&arr[j]) {
                        Ordering::Greater => dp[i] = dp[i].max(dp[j] + 1),
                        Ordering::Less => dp[i] = dp[i].max(dp[j] + 1),
                        _ => {}
                    }
                }
            }
        }

        dp[n - 1]
    }
}
}