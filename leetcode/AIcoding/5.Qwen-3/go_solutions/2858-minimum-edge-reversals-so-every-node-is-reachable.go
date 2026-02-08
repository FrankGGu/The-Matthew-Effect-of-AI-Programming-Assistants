package main

func minEdgeReversals(graph [][]int, n int) int {
    adj := make([][]int, n)
    for i := 0; i < n; i++ {
        for j := 0; j < len(graph[i]); j += 2 {
            u, v := graph[i][j], graph[i][j+1]
            adj[u] = append(adj[u], v)
            adj[v] = append(adj[v], u)
        }
    }

    var dfs func(int, int) int
    dfs = func(u, parent int) int {
        res := 0
        for _, v := range adj[u] {
            if v != parent {
                res += dfs(v, u)
                if graph[u][0] != v {
                    res++
                }
            }
        }
        return res
    }

    result := dfs(0, -1)

    var dfs2 func(int, int, int) int
    dfs2 = func(u, parent, count int) int {
        if u != 0 {
            if graph[u][0] != parent {
                count++
            } else {
                count--
            }
        }
        res := count
        for _, v := range adj[u] {
            if v != parent {
                res = min(res, dfs2(v, u, count))
            }
        }
        return res
    }

    return dfs2(0, -1, result)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}