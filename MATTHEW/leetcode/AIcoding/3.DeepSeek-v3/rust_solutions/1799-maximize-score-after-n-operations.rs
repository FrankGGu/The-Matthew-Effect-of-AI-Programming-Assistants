impl Solution {
    pub fn max_score(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![-1; 1 << n];
        Self::dfs(&nums, 0, &mut dp)
    }

    fn dfs(nums: &Vec<i32>, mask: usize, dp: &mut Vec<i32>) -> i32 {
        if dp[mask] != -1 {
            return dp[mask];
        }
        let k = (mask.count_ones() as usize) / 2;
        let m = nums.len();
        if 2 * k == m {
            return 0;
        }
        let mut res = 0;
        for i in 0..m {
            if (mask & (1 << i)) == 0 {
                for j in i + 1..m {
                    if (mask & (1 << j)) == 0 {
                        let new_mask = mask | (1 << i) | (1 << j);
                        let gcd_val = Self::gcd(nums[i], nums[j]);
                        let current = (k + 1) as i32 * gcd_val + Self::dfs(nums, new_mask, dp);
                        res = res.max(current);
                    }
                }
            }
        }
        dp[mask] = res;
        res
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}