func canCross(stones []int) bool {
    n := len(stones)
    if n == 0 || stones[0] != 0 {
        return false
    }

    dp := make(map[int]map[int]bool)
    for _, stone := range stones {
        dp[stone] = make(map[int]bool)
    }
    dp[0][0] = true

    for i := 0; i < n; i++ {
        for k := range dp[stones[i]] {
            for j := -1; j <= 1; j++ {
                step := k + j
                if step > 0 {
                    nextStone := stones[i] + step
                    if _, ok := dp[nextStone]; ok {
                        dp[nextStone][step] = true
                    }
                }
            }
        }
    }

    lastStone := stones[n-1]
    for k := range dp[lastStone] {
        if k > 0 {
            return true
        }
    }
    return false
}