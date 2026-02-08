func findRotateSteps(ring string, key string) int {
    ringLen := len(ring)
    keyLen := len(key)

    dp := make([][]int, keyLen+1)
    for i := range dp {
        dp[i] = make([]int)(ringLen)
        for j := range dp[i] {
            dp[i][j] = int(1e9)
        }
    }

    for j := 0; j < ringLen; j++ {
        dp[0][j] = 0
    }

    for i := 1; i <= keyLen; i++ {
        for j := 0; j < ringLen; j++ {
            if key[i-1] == ring[j] {
                for k := 0; k < ringLen; k++ {
                    if dp[i-1][k] != int(1e9) {
                        steps := min(abs(j-k), ringLen-abs(j-k)) + 1
                        dp[i][j] = min(dp[i][j], dp[i-1][k]+steps)
                    }
                }
            }
        }
    }

    result := int(1e9)
    for j := 0; j < ringLen; j++ {
        result = min(result, dp[keyLen][j])
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}