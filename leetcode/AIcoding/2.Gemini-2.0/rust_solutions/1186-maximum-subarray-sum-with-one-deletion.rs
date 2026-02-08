impl Solution {
    pub fn maximum_subarray_sum_with_one_deletion(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut dp = vec![(0, 0); n];
        dp[0].0 = arr[0];
        let mut ans = arr[0];

        for i in 1..n {
            dp[i].0 = std::cmp::max(arr[i], dp[i - 1].0 + arr[i]);
            ans = std::cmp::max(ans, dp[i].0);
        }

        for i in 1..n {
            dp[i].1 = std::cmp::max(arr[i], dp[i - 1].0);
        }

        for i in 1..n {
            if i > 1 {
                dp[i].1 = std::cmp::max(dp[i].1, dp[i - 2].0 + arr[i]);
            }
            ans = std::cmp::max(ans, dp[i].1);
        }

        let mut left = vec![0; n];
        let mut right = vec![0; n];

        left[0] = arr[0];
        for i in 1..n {
            left[i] = std::cmp::max(arr[i], left[i - 1] + arr[i]);
        }

        right[n - 1] = arr[n - 1];
        for i in (0..n - 1).rev() {
            right[i] = std::cmp::max(arr[i], right[i + 1] + arr[i]);
        }

        for i in 1..n - 1 {
            ans = std::cmp::max(ans, left[i - 1] + right[i + 1]);
        }

        ans
    }
}