func canCross(stones []int) bool {
    if len(stones) == 0 || stones[0] != 0 {
        return false
    }
    n := len(stones)
    dp := make([]map[int]bool, n)
    for i := range dp {
        dp[i] = make(map[int]bool)
    }
    dp[0][0] = true
    for i := 0; i < n; i++ {
        for k := range dp[i] {
            for j := -1; j <= 1; j++ {
                nextK := k + j
                if nextK > 0 {
                    pos := stones[i] + nextK
                    idx := search(stones, pos)
                    if idx != -1 {
                        dp[idx][nextK] = true
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

func search(stones []int, target int) int {
    left, right := 0, len(stones)-1
    for left <= right {
        mid := left + (right-left)/2
        if stones[mid] == target {
            return mid
        } else if stones[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return -1
}