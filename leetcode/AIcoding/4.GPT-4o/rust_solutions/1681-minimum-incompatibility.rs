impl Solution {
    pub fn minimum_incompatibility(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut ans = i32::MAX;
        let mut mask = vec![0; 1 << n];
        let mut dp = vec![i32::MAX; 1 << n];
        dp[0] = 0;

        for i in 0..n {
            for j in (0..(1 << n)).rev() {
                if j & (1 << i) == 0 {
                    let new_mask = j | (1 << i);
                    mask[new_mask] = mask[j] ^ nums[i];
                    if mask[new_mask] != 0 {
                        dp[new_mask] = dp[new_mask].min(dp[j] + 1);
                    }
                }
            }
        }

        for j in 0..(1 << n) {
            if dp[j] == k {
                let mut sum = 0;
                let mut used = vec![false; n];
                for i in 0..n {
                    if j & (1 << i) != 0 {
                        sum += nums[i];
                        used[i] = true;
                    }
                }
                if sum > 0 {
                    ans = ans.min(sum);
                }
            }
        }

        if ans == i32::MAX { -1 } else { ans }
    }
}