impl Solution {
    pub fn minimum_xor_sum(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut dp = vec![std::i32::MAX; 1 << n];
        dp[0] = 0;

        for mask in 0..1 << n {
            let bits = mask.count_ones() as usize;
            for j in 0..n {
                if mask & (1 << j) == 0 {
                    let next_mask = mask | (1 << j);
                    let cost = (nums1[bits] ^ nums2[j]) as i32;
                    if dp[next_mask] > dp[mask] + cost {
                        dp[next_mask] = dp[mask] + cost;
                    }
                }
            }
        }

        dp[(1 << n) - 1]
    }
}