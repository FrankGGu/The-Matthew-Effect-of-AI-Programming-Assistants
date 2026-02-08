func waysToDivideCorridor(corridor []int) int {
    const mod = 1e9 + 7
    n := len(corridor)
    if n%2 == 1 {
        return 0
    }

    count := 0
    for _, v := range corridor {
        if v == 1 {
            count++
        }
    }

    if count%2 == 1 {
        return 0
    }

    pairs := count / 2
    dp := make([]int, pairs+1)
    dp[0] = 1

    for i := 0; i < n; i++ {
        if corridor[i] == 1 {
            continue
        }
        for j := pairs; j > 0; j-- {
            dp[j] = (dp[j] + dp[j-1]) % mod
        }
    }

    result := dp[pairs]
    for i := 1; i <= pairs; i++ {
        result = (result * i) % mod
    }

    return result
}