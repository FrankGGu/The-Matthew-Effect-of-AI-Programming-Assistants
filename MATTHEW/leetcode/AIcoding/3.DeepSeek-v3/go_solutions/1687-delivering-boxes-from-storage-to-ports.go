func boxDelivering(boxes [][]int, portsCount int, maxBoxes int, maxWeight int) int {
    n := len(boxes)
    dp := make([]int, n+1)
    for i := range dp {
        dp[i] = math.MaxInt32
    }
    dp[0] = 0

    left := 0
    totalWeight := 0
    diffPort := 0

    for right := 0; right < n; right++ {
        if right == 0 || boxes[right][0] != boxes[right-1][0] {
            diffPort++
        }
        totalWeight += boxes[right][1]

        for left <= right && (right - left + 1 > maxBoxes || totalWeight > maxWeight) {
            totalWeight -= boxes[left][1]
            if left < right && boxes[left][0] != boxes[left+1][0] {
                diffPort--
            }
            left++
        }

        if left <= right {
            dp[right+1] = dp[left] + diffPort + 1
            if left > 0 && boxes[left-1][0] == boxes[right][0] {
                dp[right+1] = min(dp[right+1], dp[left] + diffPort)
            }
        }
    }

    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}