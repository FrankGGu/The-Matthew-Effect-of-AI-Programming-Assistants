func maxJumps(arr []int, d int) int {
    n := len(arr)
    dp := make([]int, n)
    for i := range dp {
        dp[i] = 1
    }

    indices := make([]int, n)
    for i := 0; i < n; i++ {
        indices[i] = i
    }

    sort.Slice(indices, func(i, j int) bool {
        return arr[indices[i]] < arr[indices[j]]
    })

    for _, index := range indices {
        for i := 1; i <= d; i++ {
            if index+i < n && arr[index+i] >= arr[index] {
                break
            }
            if index+i < n {
                dp[index+i] = max(dp[index+i], dp[index]+1)
            }
        }
        for i := 1; i <= d; i++ {
            if index-i >= 0 && arr[index-i] >= arr[index] {
                break
            }
            if index-i >= 0 {
                dp[index-i] = max(dp[index-i], dp[index]+1)
            }
        }
    }

    maxJumps := 0
    for _, jumps := range dp {
        maxJumps = max(maxJumps, jumps)
    }

    return maxJumps
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}