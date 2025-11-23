func maximumTotalDamage(power []int) int64 {
    freq := make(map[int]int)
    for _, p := range power {
        freq[p]++
    }

    uniquePowers := make([]int, 0, len(freq))
    for p := range freq {
        uniquePowers = append(uniquePowers, p)
    }
    sort.Ints(uniquePowers)

    n := len(uniquePowers)
    dp := make([]int64, n)

    for i := 0; i < n; i++ {
        currentPower := uniquePowers[i]
        total := int64(currentPower * freq[currentPower])

        maxPrev := int64(0)
        for j := i - 1; j >= 0; j-- {
            if uniquePowers[j] < currentPower - 2 {
                if dp[j] > maxPrev {
                    maxPrev = dp[j]
                }
            }
        }

        dp[i] = total + maxPrev
        if i > 0 && dp[i-1] > dp[i] {
            dp[i] = dp[i-1]
        }
    }

    return dp[n-1]
}