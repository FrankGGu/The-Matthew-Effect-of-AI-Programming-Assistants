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
            for jump := -1; jump <= 1; jump++ {
                nextJump := k + jump
                if nextJump > 0 {
                    nextStone := stones[i] + nextJump
                    if _, exists := dp[nextStone]; exists {
                        dp[nextStone][nextJump] = true
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