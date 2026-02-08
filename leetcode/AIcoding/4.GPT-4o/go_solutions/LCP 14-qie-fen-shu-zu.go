func splitArraySameAverage(A []int) bool {
    n := len(A)
    totalSum := 0
    for _, num := range A {
        totalSum += num
    }

    for k := 1; k <= n/2; k++ {
        if totalSum*k%n == 0 {
            targetSum := totalSum * k / n
            if canPartition(A, n, k, targetSum) {
                return true
            }
        }
    }
    return false
}

func canPartition(A []int, n, k, targetSum int) bool {
    dp := make([]map[int]bool, k+1)
    for i := range dp {
        dp[i] = make(map[int]bool)
    }
    dp[0][0] = true

    for _, num := range A {
        for i := k; i >= 1; i-- {
            for sum := targetSum; sum >= num; sum-- {
                if dp[i-1][sum-num] {
                    dp[i][sum] = true
                }
            }
        }
    }

    return dp[k][targetSum]
}