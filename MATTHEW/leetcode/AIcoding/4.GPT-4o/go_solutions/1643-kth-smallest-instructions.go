func kthSmallest(instructions []int, k int) int {
    const mod = 1e9 + 7
    n := len(instructions)
    count := make([]int, 1001)

    for _, num := range instructions {
        count[num]++
    }

    dp := make([]int, n+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] * (i + 1) % mod
    }

    result := 0
    prefix := 0
    for i := 1; i <= 1000; i++ {
        if count[i] > 0 {
            for j := 1; j <= count[i]; j++ {
                prefix++
                if prefix == k {
                    result = i
                    break
                }
                if prefix > k {
                    break
                }
            }
        }
        if result > 0 {
            break
        }
    }

    return result
}