func shortestSuperstring(words []string) string {
    n := len(words)
    overlaps := make([][]int, n)
    for i := range overlaps {
        overlaps[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if i == j {
                continue
            }
            a, b := words[i], words[j]
            maxOverlap := min(len(a), len(b))
            for k := maxOverlap; k >= 0; k-- {
                if strings.HasSuffix(a, b[:k]) {
                    overlaps[i][j] = k
                    break
                }
            }
        }
    }

    dp := make([][]string, 1<<n)
    for i := range dp {
        dp[i] = make([]string, n)
    }

    for mask := 1; mask < (1 << n); mask++ {
        for bit := 0; bit < n; bit++ {
            if (mask & (1 << bit)) == 0 {
                continue
            }
            prevMask := mask ^ (1 << bit)
            if prevMask == 0 {
                dp[mask][bit] = words[bit]
                continue
            }
            for last := 0; last < n; last++ {
                if (prevMask & (1 << last)) == 0 {
                    continue
                }
                candidate := dp[prevMask][last] + words[bit][overlaps[last][bit]:]
                if dp[mask][bit] == "" || len(candidate) < len(dp[mask][bit]) {
                    dp[mask][bit] = candidate
                }
            }
        }
    }

    mask := (1 << n) - 1
    res := dp[mask][0]
    for i := 1; i < n; i++ {
        if len(dp[mask][i]) < len(res) {
            res = dp[mask][i]
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}