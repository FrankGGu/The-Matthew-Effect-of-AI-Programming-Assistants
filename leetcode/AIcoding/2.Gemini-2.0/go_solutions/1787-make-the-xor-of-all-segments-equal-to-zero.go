func minChanges(nums []int, k int) int {
    n := len(nums)
    maxVal := 1024
    dp := make([]int, maxVal)
    for i := range dp {
        dp[i] = n
    }
    dp[0] = 0

    for i := 0; i < k; i++ {
        cnt := make(map[int]int)
        size := 0
        for j := i; j < n; j += k {
            cnt[nums[j]]++
            size++
        }

        minVal := n
        for _, v := range cnt {
            if v < minVal {
                minVal = v
            }
        }

        newDp := make([]int, maxVal)
        for j := range newDp {
            newDp[j] = n
        }

        for xor := 0; xor < maxVal; xor++ {
            for num := 0; num < maxVal; num++ {
                newDp[xor^num] = min(newDp[xor^num], dp[xor] + size - cnt[num])
            }
        }

        minVal = n
        for _, v := range newDp {
            if v < minVal {
                minVal = v
            }
        }

        for j := range dp {
            dp[j] = minVal
        }

        for xor := 0; xor < maxVal; xor++ {
            dp[xor] = min(dp[xor], newDp[xor])
        }
    }

    return dp[0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}