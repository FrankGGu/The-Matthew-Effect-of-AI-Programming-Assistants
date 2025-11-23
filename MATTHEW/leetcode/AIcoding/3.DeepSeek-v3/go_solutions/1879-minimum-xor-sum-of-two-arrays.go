func minimumXORSum(nums1 []int, nums2 []int) int {
    n := len(nums1)
    dp := make([]int, 1<<n)
    for i := range dp {
        dp[i] = math.MaxInt32
    }
    dp[0] = 0

    for mask := 0; mask < (1 << n); mask++ {
        bits := bits.OnesCount(uint(mask))
        for i := 0; i < n; i++ {
            if mask & (1 << i) == 0 {
                nextMask := mask | (1 << i)
                if dp[nextMask] > dp[mask] + (nums1[bits] ^ nums2[i]) {
                    dp[nextMask] = dp[mask] + (nums1[bits] ^ nums2[i])
                }
            }
        }
    }

    return dp[(1 << n) - 1]
}