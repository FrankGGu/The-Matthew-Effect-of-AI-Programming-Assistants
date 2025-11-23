impl Solution {
    pub fn min_space_wasted_with_k_resizing_operations(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        // Effective k: if k is large enough to make each element its own segment,
        // the waste is 0. This happens when k >= n-1.
        let k_eff = (k as usize).min(n - 1);

        // dp[i][j] represents the minimum total space wasted for the prefix nums[0...i-1]
        // using exactly j resizing operations.
        // i ranges from 0 to n.
        // j ranges from 0 to k_eff.
        let mut dp = vec![vec![std::i64::MAX; k_eff + 1]; n + 1];

        // Base case: 0 elements, 0 resizes, 0 waste.
        dp[0][0] = 0;

        // Iterate through each possible end point of the array prefix
        for i in 1..=n {
            // Iterate through each possible number of resizing operations
            for j in 0..=k_eff {
                let mut current_max = 0;
                let mut current_sum = 0;

                // Iterate backwards from i-1 to find the start index 'p' of the last segment.
                // The last segment is nums[p...i-1].
                for p in (0..i).rev() {
                    current_max = current_max.max(nums[p]);
                    current_sum += nums[p] as i64;

                    // Calculate waste for the current last segment
                    let waste_last_segment = (i - p) as i64 * current_max as i64 - current_sum;

                    if j == 0 {
                        // If 0 resizes, it means there is only 1 segment (nums[0...i-1]).
                        // So, the last segment must start at index 0 (p=0).
                        if p == 0 {
                            dp[i][0] = waste_last_segment;
                        }
                    } else {
                        // If j > 0 resizes, the prefix nums[0...p-1] must have used j-1 resizes.
                        if dp[p][j - 1] != std::i64::MAX {
                            dp[i][j] = dp[i][j].min(dp[p][j - 1] + waste_last_segment);
                        }
                    }
                }
            }
        }

        // The final answer is the minimum waste for all 'n' elements,
        // using any number of resizes from 0 to k_eff.
        let mut min_total_waste = std::i64::MAX;
        for j in 0..=k_eff {
            min_total_waste = min_total_waste.min(dp[n][j]);
        }

        min_total_waste as i32
    }
}