func canCross(stones []int, t int) bool {
    n := len(stones)
    if n == 0 || stones[0] != 0 || stones[n-1] != t {
        return false
    }

    dp := make([]map[int]bool, n)
    for i := range dp {
        dp[i] = make(map[int]bool)
    }
    dp[0][0] = true

    for i := 0; i < n; i++ {
        for k := range dp[i] {
            for j := -1; j <= 1; j++ {
                if k+j > 0 {
                    pos := stones[i] + k + j
                    for p := 0; p < n; p++ {
                        if stones[p] == pos {
                            dp[p][k+j] = true
                        }
                    }
                }
            }
        }
    }

    for k := range dp[n-1] {
        if k > 0 {
            return true
        }
    }
    return false
}

func canCrossAll(stones []int) int {
    left, right := 0, len(stones)-1
    for left < right {
        mid := left + (right-left+1)/2
        if canCross(stones[:mid+1], stones[mid]) {
            left = mid
        } else {
            right = mid - 1
        }
    }
    return left + 1
}

func lastDayToCross(stones []int) int {
    return canCrossAll(stones)
}