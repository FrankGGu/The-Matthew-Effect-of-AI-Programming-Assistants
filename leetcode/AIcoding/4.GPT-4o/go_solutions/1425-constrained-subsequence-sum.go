func constrainedSubsetSum(nums []int, k int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)
    for i := range dp {
        dp[i] = nums[i]
    }

    deque := []int{}
    maxSum := nums[0]

    for i := 0; i < n; i++ {
        if i > 0 {
            if len(deque) > 0 {
                dp[i] = max(dp[i], dp[deque[0]] + nums[i])
            }
        }
        maxSum = max(maxSum, dp[i])

        // Maintain the deque
        for len(deque) > 0 && dp[deque[len(deque)-1]] < dp[i] {
            deque = deque[:len(deque)-1]
        }
        deque = append(deque, i)

        if i-k >= 0 {
            deque = deque[1:]
        }
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}