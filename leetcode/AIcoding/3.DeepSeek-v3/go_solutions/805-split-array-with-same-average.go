func splitArraySameAverage(nums []int) bool {
    n := len(nums)
    total := 0
    for _, num := range nums {
        total += num
    }

    possible := false
    for k := 1; k <= n/2; k++ {
        if total*k%n == 0 {
            possible = true
            break
        }
    }
    if !possible {
        return false
    }

    dp := make([]map[int]bool, n/2+1)
    for i := range dp {
        dp[i] = make(map[int]bool)
    }
    dp[0][0] = true

    for _, num := range nums {
        for k := n/2; k >= 1; k-- {
            for sum := range dp[k-1] {
                newSum := sum + num
                if total*k == newSum*n {
                    return true
                }
                dp[k][newSum] = true
            }
        }
    }

    return false
}