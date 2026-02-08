package main

func numberOfWays(roads [][]int) int {
    n := len(roads)
    adj := make([][]int, n)
    for _, r := range roads {
        u, v := r[0], r[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    var dfs func(node, parent int) (int, int)
    dfs = func(node, parent int) (int, int) {
        count := 1
        total := 0
        for _, neighbor := range adj[node] {
            if neighbor == parent {
                continue
            }
            childCount, childTotal := dfs(neighbor, node)
            count += childCount
            total += childTotal + childCount*(count-1)
        }
        return count, total
    }

    _, result := dfs(0, -1)
    return result
}