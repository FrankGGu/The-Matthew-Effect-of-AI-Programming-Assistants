impl Solution {
    pub fn special_perm(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![0; n]; 1 << n];
        for i in 0..n {
            dp[1 << i][i] = 1;
        }
        for mask in 0..1 << n {
            for last in 0..n {
                if mask & (1 << last) == 0 {
                    continue;
                }
                for next in 0..n {
                    if mask & (1 << next) != 0 {
                        continue;
                    }
                    if nums[last] % nums[next] == 0 || nums[next] % nums[last] == 0 {
                        let new_mask = mask | (1 << next);
                        dp[new_mask][next] = (dp[new_mask][next] + dp[mask][last]) % 1_000_000_007;
                    }
                }
            }
        }
        let mut res = 0;
        for i in 0..n {
            res = (res + dp[(1 << n) - 1][i]) % 1_000_000_007;
        }
        res
    }
}