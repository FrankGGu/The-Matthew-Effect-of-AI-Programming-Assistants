impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![std::i32::MAX; 1 << n];
        dp[0] = 0;

        for i in 0..(1 << n) {
            if dp[i] == std::i32::MAX {
                continue;
            }

            let mut current_subarray = Vec::new();
            for j in 0..n {
                if (i & (1 << j)) == 0 {
                    current_subarray.push(j);
                }
            }

            if current_subarray.is_empty() {
                return dp[i];
            }

            for j in 0..current_subarray.len() {
                for l in (j + 1)..current_subarray.len() {
                    let idx1 = current_subarray[j];
                    let idx2 = current_subarray[l];

                    let next_mask = i | (1 << idx1) | (1 << idx2);
                    let cost = (nums[idx1] - nums[idx2]).abs();

                    if cost <= k {
                        dp[next_mask] = dp[next_mask].min(dp[i] + 1);
                    }
                }
            }

            if current_subarray.len() >= 1 {
                let idx = current_subarray[0];
                let next_mask = i | (1 << idx);
                dp[next_mask] = dp[next_mask].min(dp[i]);
            }
        }

        dp[(1 << n) - 1]
    }
}