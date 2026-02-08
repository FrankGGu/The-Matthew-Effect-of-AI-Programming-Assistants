impl Solution {
    pub fn minimum_xor_sum(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut dp = vec![i32::MAX; 1 << n];
        dp[0] = 0;

        for mask in 0..(1 << n) {
            if dp[mask] == i32::MAX {
                continue;
            }
            let i = mask.count_ones() as usize;
            for j in 0..n {
                if (mask & (1 << j)) == 0 {
                    let new_mask = mask | (1 << j);
                    dp[new_mask] = dp[new_mask].min(dp[mask] + (nums1[i] ^ nums2[j]));
                }
            }
        }

        dp[(1 << n) - 1]
    }
}