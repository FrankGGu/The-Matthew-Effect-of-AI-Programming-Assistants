package main

func stoneGameVII(stones []int) int {
    n := len(stones)

    prefixSum := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i] + stones[i]
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1

            // S(x, y) calculates sum of stones[x...y]
            // S(x, y) = prefixSum[y+1] - prefixSum[x]

            // Option 1: Current player removes stones[i] (leftmost)
            // Score gained by current player = sum of stones[i+1...j]
            // Remaining game is stones[i+1...j], next player plays optimally, resulting in dp[i+1][j] for them.
            scoreIfRemoveLeft := (prefixSum[j+1] - prefixSum[i+1]) - dp[i+1][j]

            // Option 2: Current player removes stones[j] (rightmost)
            // Score gained by current player = sum of stones[i...j-1]
            // Remaining game is stones[i...j-1], next player plays optimally, resulting in dp[i][j-1] for them.
            scoreIfRemoveRight := (prefixSum[j] - prefixSum[i]) - dp[i][j-1]

            dp[i][j] = max(scoreIfRemoveLeft, scoreIfRemoveRight)
        }
    }

    return dp[0][n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}