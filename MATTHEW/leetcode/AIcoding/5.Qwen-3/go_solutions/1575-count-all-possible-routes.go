package main

func countRoutes(roads [][]int, start int, end int) int {
    const MOD = 1000000007
    n := len(roads)
    graph := make([][]int, n)
    for _, road := range roads {
        u, v, dist := road[0], road[1], road[2]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    memo := make(map[string]int)
    var dfs func(int, int) int
    dfs = func(node, prev int) int {
        key := fmt.Sprintf("%d,%d", node, prev)
        if val, ok := memo[key]; ok {
            return val
        }
        res := 0
        if node == end {
            res = 1
        }
        for _, neighbor := range graph[node] {
            if neighbor != prev {
                res = (res + dfs(neighbor, node)) % MOD
            }
        }
        memo[key] = res
        return res
    }

    return dfs(start, -1)
}