func numFactoredBinaryTrees(arr []int) int {
    const mod = 1e9 + 7
    sort.Ints(arr)
    n := len(arr)
    dp := make(map[int]int, n)
    for _, num := range arr {
        dp[num] = 1
    }

    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            if arr[i]%arr[j] == 0 {
                complement := arr[i] / arr[j]
                if _, exists := dp[complement]; exists {
                    dp[arr[i]] = (dp[arr[i]] + dp[arr[j]] * dp[complement]) % mod
                }
            }
        }
    }

    total := 0
    for _, v := range dp {
        total = (total + v) % mod
    }
    return total
}