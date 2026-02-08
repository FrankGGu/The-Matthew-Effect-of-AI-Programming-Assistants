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
            if i, ok := index[arr[k]-arr[j]]; ok && i < j {
                if dp[i][j] >= 3 {
                    dp[j][k] = dp[i][j] + 1
                } else {
                    dp[j][k] = 3
                }
                if dp[j][k] > maxLen {
                    maxLen = dp[j][k]
                }
            }
        }
    }

    if maxLen >= 3 {
        return maxLen
    }
    return 0
}