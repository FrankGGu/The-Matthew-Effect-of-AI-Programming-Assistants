func minBoxes(boxes []int) int {
    n := len(boxes)
    sort.Ints(boxes)
    total := 0
    for _, box := range boxes {
        total += box
    }

    dp := make([]int, total+1)
    for i := range dp {
        dp[i] = n + 1
    }
    dp[0] = 0

    for _, box := range boxes {
        for j := total; j >= box; j-- {
            dp[j] = min(dp[j], dp[j-box]+1)
        }
    }

    for i := total; i >= 0; i-- {
        if dp[i] <= n {
            return dp[i]
        }
    }

    return n
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}