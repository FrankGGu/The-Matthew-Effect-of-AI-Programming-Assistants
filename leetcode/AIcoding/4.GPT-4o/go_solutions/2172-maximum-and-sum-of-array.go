func maximumANDSum(nums []int, numSlots int) int {
    n := len(nums)
    maxMask := 1 << (numSlots * 2)
    dp := make([]int, maxMask)

    for mask := 0; mask < maxMask; mask++ {
        count := make([]int, numSlots)
        for i := 0; i < numSlots; i++ {
            count[i] = (mask >> (i * 2)) & 3
        }
        for i := 0; i < n; i++ {
            for j := 0; j < numSlots; j++ {
                if count[j] < 2 {
                    newMask := mask | (1 << (j * 2))
                    dp[newMask] = max(dp[newMask], dp[mask]+(nums[i]&^(1<<j)))
                }
            }
        }
    }
    return dp[maxMask-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}