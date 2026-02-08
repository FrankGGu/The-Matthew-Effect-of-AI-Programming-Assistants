impl Solution {
    pub fn minimum_xor_sum(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut dp = vec![i32::MAX; 1 << n];
        dp[0] = 0;

        for mask in 0..(1 << n) {
            if dp[mask] == i32::MAX {
                continue;
            }

            let k = mask.count_ones() as usize; // k is the index for nums1
            if k == n {
                continue; // All nums1 elements have been assigned
            }

            // Try to assign nums1[k] to an unused element from nums2
            for j in 0..n {
                // If nums2[j] has not been used in the current mask
                if (mask & (1 << j)) == 0 {
                    let next_mask = mask | (1 << j);
                    dp[next_mask] = dp[next_mask].min(dp[mask] + (nums1[k] ^ nums2[j]));
                }
            }
        }

        dp[(1 << n) - 1]
    }
}