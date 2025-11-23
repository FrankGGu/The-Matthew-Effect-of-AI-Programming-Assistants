func lenLongestFibSubseq(arr []int) int {
    n := len(arr)
    index := make(map[int]int, n)
    for i, num := range arr {
        index[num] = i
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    maxLen := 0
    for k := 0; k < n; k++ {
        for j := 0; j < k; j++ {
            if arr[k]-arr[j] < arr[j] {
                if i, exists := index[arr[k]-arr[j]]; exists {
                    dp[j][k] = dp[i][j] + 1
                    if dp[j][k] > maxLen {
                        maxLen = dp[j][k]
                    }
                }
            }
        }
    }

    if maxLen > 0 {
        return maxLen + 2
    }
    return 0
}