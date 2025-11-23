impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn min_cost(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut dp = vec![i32::MAX; n];
        dp[0] = 0;

        for i in 1..n {
            for j in 0..i {
                let cost = match arr[i].cmp(&arr[j]) {
                    Ordering::Less => arr[j] - arr[i],
                    Ordering::Equal => 0,
                    Ordering::Greater => arr[i] - arr[j],
                };
                if dp[j] != i32::MAX {
                    dp[i] = dp[i].min(dp[j] + cost);
                }
            }
        }

        dp[n - 1]
    }
}
}