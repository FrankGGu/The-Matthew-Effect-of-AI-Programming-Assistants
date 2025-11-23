impl Solution {
    pub fn special_perm(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![0; n]; 1 << n];
        let mut ans = 0;
        let mod_val = 1_000_000_007;

        for i in 0..n {
            dp[1 << i][i] = 1;
        }

        for mask in 1..(1 << n) {
            for i in 0..n {
                if (mask & (1 << i)) != 0 {
                    for j in 0..n {
                        if (mask & (1 << j)) == 0 {
                            if nums[i] % nums[j] == 0 || nums[j] % nums[i] == 0 {
                                dp[mask | (1 << j)][j] = (dp[mask | (1 << j)][j] + dp[mask][i]) % mod_val;
                            }
                        }
                    }
                }
            }
        }

        for i in 0..n {
            ans = (ans + dp[(1 << n) - 1][i]) % mod_val;
        }

        ans
    }
}