func numberWays(hats [][]int) int {
    mod := int(1e9) + 7
    n := len(hats)
    maxHat := 0
    for _, list := range hats {
        for _, h := range list {
            if h > maxHat {
                maxHat = h
            }
        }
    }

    hatToPeople := make([][]int, maxHat+1)
    for i := 0; i < n; i++ {
        for _, h := range hats[i] {
            hatToPeople[h] = append(hatToPeople[h], i)
        }
    }

    dp := make([]int, 1<<n)
    dp[0] = 1

    for h := 1; h <= maxHat; h++ {
        for mask := (1 << n) - 1; mask >= 0; mask-- {
            for _, p := range hatToPeople[h] {
                if mask & (1 << p) == 0 {
                    nextMask := mask | (1 << p)
                    dp[nextMask] = (dp[nextMask] + dp[mask]) % mod
                }
            }
        }
    }

    return dp[(1<<n)-1]
}