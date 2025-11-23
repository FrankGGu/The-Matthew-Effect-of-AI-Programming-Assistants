func minNumberOfSemesters(n int, relations [][]int, k int) int {
    indegree := make([]int, n+1)
    graph := make([][]int, n+1)

    for _, rel := range relations {
        a, b := rel[0], rel[1]
        graph[a] = append(graph[a], b)
        indegree[b]++
    }

    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = int(1e9)
    }
    dp[0] = 0

    for mask := 0; mask < (1 << n); mask++ {
        count := 0
        for i := 0; i < n; i++ {
            if (mask>>i)&1 == 1 {
                count++
            }
        }

        if count == 0 {
            continue
        }

        nextMask := mask
        for i := 0; i < n; i++ {
            if (mask>>i)&1 == 0 && indegree[i+1] == 0 {
                nextMask |= 1 << i
                for _, neighbor := range graph[i+1] {
                    indegree[neighbor]--
                }
            }
        }

        if nextMask != mask {
            continue
        }

        for j := 0; j < n; j++ {
            if (nextMask>>j)&1 == 1 {
                sem := dp[mask] + 1
                if sem <= k {
                    dp[nextMask] = min(dp[nextMask], sem)
                }
            }
        }
    }

    return dp[(1<<n)-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}