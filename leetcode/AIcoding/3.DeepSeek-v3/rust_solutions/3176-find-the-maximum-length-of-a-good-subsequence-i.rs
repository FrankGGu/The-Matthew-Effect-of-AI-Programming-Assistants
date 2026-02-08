impl Solution {
    pub fn maximum_length(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut dp = vec![vec![1; k + 1]; n];
        let mut res = 1;

        for i in 1..n {
            for j in 0..=k {
                for l in 0..i {
                    let cost = if nums[l] == nums[i] { 0 } else { 1 };
                    if j >= cost {
                        dp[i][j] = dp[i][j].max(dp[l][j - cost] + 1);
                    }
                }
                res = res.max(dp[i][j]);
            }
        }

        res
    }
}