impl Solution {
    pub fn make_array_non_decreasing(arr: Vec<i32>, changes: Vec<(i32, i32)>) -> i32 {
        let mut dp = vec![i32::MAX; arr.len()];
        dp[0] = arr[0];

        for (old, new) in changes {
            for i in (0..arr.len()).rev() {
                if arr[i] == old {
                    dp[i] = dp[i].min(new);
                }
            }
        }

        for i in 1..arr.len() {
            dp[i] = dp[i].min(dp[i - 1]);
            if arr[i] < dp[i] {
                dp[i] = arr[i];
            }
        }

        if dp.iter().all(|&x| x != i32::MAX) {
            dp.iter().max().unwrap() - dp.iter().min().unwrap() + 1
        } else {
            -1
        }
    }
}