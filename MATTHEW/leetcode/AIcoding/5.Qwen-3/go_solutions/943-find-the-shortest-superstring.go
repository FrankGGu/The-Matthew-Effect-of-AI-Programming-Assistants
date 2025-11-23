package main

func findShortestSuperstring(strs []string) string {
    n := len(strs)
    if n == 0 {
        return ""
    }
    if n == 1 {
        return strs[0]
    }

    // Calculate the overlap between two strings
    overlap := func(a, b string) int {
        maxLen := min(len(a), len(b))
        for i := maxLen; i > 0; i-- {
            if a[len(a)-i:] == b[:i] {
                return i
            }
        }
        return 0
    }

    // Create a graph of overlaps
    graph := make([][]int, n)
    for i := 0; i < n; i++ {
        graph[i] = make([]int, n)
        for j := 0; j < n; j++ {
            if i != j {
                graph[i][j] = overlap(strs[i], strs[j])
            }
        }
    }

    // dp[mask][i] = length of the shortest superstring with the set of characters represented by mask, ending with i-th string
    dp := make([][]int, 1<<n)
    for i := 0; i < 1<<n; i++ {
        dp[i] = make([]int, n)
    }

    // prev[mask][i] = the previous index that leads to the optimal path
    prev := make([][]int, 1<<n)
    for i := 0; i < 1<<n; i++ {
        prev[i] = make([]int, n)
    }

    // Initialize dp
    for i := 0; i < n; i++ {
        dp[1<<i][i] = len(strs[i])
    }

    // Fill dp
    for mask := 1; mask < 1<<n; mask++ {
        for last := 0; last < n; last++ {
            if (mask & (1 << last)) == 0 {
                continue
            }
            for curr := 0; curr < n; curr++ {
                if (mask & (1 << curr)) != 0 {
                    continue
                }
                newMask := mask | (1 << curr)
                if dp[newMask][curr] < dp[mask][last]+graph[last][curr] {
                    dp[newMask][curr] = dp[mask][last] + graph[last][curr]
                    prev[newMask][curr] = last
                }
            }
        }
    }

    // Find the minimum superstring
    minLen := math.MaxInt32
    var end int
    for i := 0; i < n; i++ {
        if dp[(1<<n)-1][i] < minLen {
            minLen = dp[(1<<n)-1][i]
            end = i
        }
    }

    // Reconstruct the superstring
    result := make([]string, n)
    for i := 0; i < n; i++ {
        result[i] = strs[end]
        end = prev[(1<<n)-1][end]
    }

    // Reverse to get the correct order
    for i, j := 0, n-1; i < j; i, j = i+1, j-1 {
        result[i], result[j] = result[j], result[i]
    }

    // Combine the strings
    res := ""
    for _, s := range result {
        res += s
    }

    return res
}