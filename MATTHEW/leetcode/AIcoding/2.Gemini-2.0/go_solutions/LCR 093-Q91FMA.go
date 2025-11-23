func lenLongestFibSubseq(arr []int) int {
    n := len(arr)
    index := make(map[int]int)
    for i, num := range arr {
        index[num] = i
    }
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    ans := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            dp[i][j] = 2
            if idx, ok := index[arr[j]-arr[i]]; ok && idx < i {
                dp[i][j] = dp[idx][i] + 1
                if dp[i][j] > ans {
                    ans = dp[i][j]
                }
            }
        }
    }
    return ans
}