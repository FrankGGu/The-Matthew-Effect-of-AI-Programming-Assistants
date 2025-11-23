impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0;

        for i in 1..=n {
            for j in 0..i {
                let max_num = nums[j..i].iter().cloned().max().unwrap();
                if max_num <= k {
                    dp[i] = dp[i].min(dp[j] + 1);
                }
            }
        }

        if dp[n] == i32::MAX {
            -1
        } else {
            dp[n] - 1
        }
    }
}