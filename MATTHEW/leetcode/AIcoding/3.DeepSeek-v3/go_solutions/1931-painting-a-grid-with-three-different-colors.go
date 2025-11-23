func colorTheGrid(m int, n int) int {
    mod := int(1e9 + 7)
    validMasks := make([]int, 0)

    var backtrack func(pos, prevColor int, mask int)
    backtrack = func(pos, prevColor int, mask int) {
        if pos == m {
            validMasks = append(validMasks, mask)
            return
        }
        for color := 0; color < 3; color++ {
            if color != prevColor {
                backtrack(pos+1, color, mask*3 + color)
            }
        }
    }
    backtrack(0, -1, 0)

    k := len(validMasks)
    adj := make([][]int, k)
    for i := 0; i < k; i++ {
        adj[i] = make([]int, 0)
    }

    for i := 0; i < k; i++ {
        for j := i + 1; j < k; j++ {
            mask1 := validMasks[i]
            mask2 := validMasks[j]
            compatible := true
            for pos := 0; pos < m; pos++ {
                if mask1%3 == mask2%3 {
                    compatible = false
                    break
                }
                mask1 /= 3
                mask2 /= 3
            }
            if compatible {
                adj[i] = append(adj[i], j)
                adj[j] = append(adj[j], i)
            }
        }
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k)
    }
    for i := 0; i < k; i++ {
        dp[0][i] = 1
    }

    for col := 1; col < n; col++ {
        for i := 0; i < k; i++ {
            for _, j := range adj[i] {
                dp[col][i] = (dp[col][i] + dp[col-1][j]) % mod
            }
        }
    }

    res := 0
    for i := 0; i < k; i++ {
        res = (res + dp[n-1][i]) % mod
    }
    return res
}