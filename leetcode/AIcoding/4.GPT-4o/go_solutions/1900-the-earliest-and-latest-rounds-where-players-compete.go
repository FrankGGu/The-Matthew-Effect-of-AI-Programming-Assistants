func earliestAndLatest(n int, matches [][]int) [][]int {
    graph := make([][]int, n+1)
    for _, match := range matches {
        graph[match[0]] = append(graph[match[0]], match[1])
        graph[match[1]] = append(graph[match[1]], match[0])
    }

    earliest := make([]int, n+1)
    latest := make([]int, n+1)

    var dfs func(int, int, int)
    dfs = func(player, round, matchCount int) {
        if round > n {
            return
        }
        if matchCount > 0 {
            earliest[player] = min(earliest[player], round)
            latest[player] = max(latest[player], round)
        }
        for _, opponent := range graph[player] {
            dfs(opponent, round+1, matchCount-1)
        }
    }

    for i := 1; i <= n; i++ {
        earliest[i] = n + 1
        latest[i] = 0
    }

    for i := 1; i <= n; i++ {
        dfs(i, 1, len(graph[i]))
    }

    result := make([][]int, 0)
    for i := 1; i <= n; i++ {
        result = append(result, []int{earliest[i], latest[i]})
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}