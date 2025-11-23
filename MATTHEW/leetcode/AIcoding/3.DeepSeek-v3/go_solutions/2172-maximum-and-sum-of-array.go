func maximumANDSum(nums []int, numSlots int) int {
    n := len(nums)
    dp := make([]int, 1<<(2*numSlots))

    for mask := 0; mask < 1<<(2*numSlots); mask++ {
        c := bits.OnesCount(uint(mask))
        if c >= n {
            continue
        }
        for i := 0; i < numSlots; i++ {
            if (mask>>(2*i))&3 < 2 {
                nextMask := mask + (1 << (2*i))
                and := nums[c] & (i + 1)
                if dp[nextMask] < dp[mask] + and {
                    dp[nextMask] = dp[mask] + and
                }
            }
        }
    }

    maxSum := 0
    for mask := 0; mask < 1<<(2*numSlots); mask++ {
        if bits.OnesCount(uint(mask)) == n && dp[mask] > maxSum {
            maxSum = dp[mask]
        }
    }
    return maxSum
}