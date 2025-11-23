func criticalConnections(n int, connections [][]int) [][]int {
    graph := make([][]int, n)
    for _, conn := range connections {
        u, v := conn[0], conn[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    disc := make([]int, n)
    low := make([]int, n)
    time := 1
    res := [][]int{}

    var dfs func(int, int)
    dfs = func(u, parent int) {
        disc[u] = time
        low[u] = time
        time++

        for _, v := range graph[u] {
            if v == parent {
                continue
            }
            if disc[v] == 0 {
                dfs(v, u)
                low[u] = min(low[u], low[v])
                if low[v] > disc[u] {
                    res = append(res, []int{u, v})
                }
            } else {
                low[u] = min(low[u], disc[v])
            }
        }
    }

    dfs(0, -1)
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}