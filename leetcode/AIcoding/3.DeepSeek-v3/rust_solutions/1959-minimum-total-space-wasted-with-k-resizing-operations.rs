impl Solution {
    pub fn min_space_wasted_k_resizing(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![vec![i32::MAX / 2; k + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for l in 0..=k {
                if l > 0 {
                    let mut min_val = i32::MAX;
                    let mut sum = 0;
                    let mut total = 0;
                    for j in (1..=i).rev() {
                        sum += nums[j - 1];
                        min_val = min_val.min(nums[j - 1]);
                        total = sum - min_val * (i - j + 1) as i32;
                        if dp[j - 1][l - 1] != i32::MAX / 2 {
                            dp[i][l] = dp[i][l].min(dp[j - 1][l - 1] + total);
                        }
                    }
                } else {
                    let mut min_val = i32::MAX;
                    let mut sum = 0;
                    for &num in nums.iter().take(i) {
                        sum += num;
                        min_val = min_val.min(num);
                    }
                    dp[i][l] = sum - min_val * i as i32;
                }
            }
        }

        dp[n][k]
    }
}