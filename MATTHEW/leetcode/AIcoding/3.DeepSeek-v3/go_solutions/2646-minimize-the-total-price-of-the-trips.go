func minimumTotalPrice(n int, edges [][]int, price []int, trips [][]int) int {
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    count := make([]int, n)
    for _, trip := range trips {
        u, v := trip[0], trip[1]
        parent := make([]int, n)
        for i := range parent {
            parent[i] = -1
        }
        q := []int{u}
        parent[u] = u
        found := false
        for len(q) > 0 && !found {
            curr := q[0]
            q = q[1:]
            for _, neighbor := range adj[curr] {
                if parent[neighbor] == -1 {
                    parent[neighbor] = curr
                    if neighbor == v {
                        found = true
                        break
                    }
                    q = append(q, neighbor)
                }
            }
        }
        node := v
        for node != u {
            count[node]++
            node = parent[node]
        }
        count[u]++
    }

    var dfs func(int, int) (int, int)
    dfs = func(node, parent int) (int, int) {
        full := price[node] * count[node]
        half := full / 2
        for _, neighbor := range adj[node] {
            if neighbor != parent {
                f, h := dfs(neighbor, node)
                full += min(f, h)
                half += f
            }
        }
        return full, half
    }
    f, h := dfs(0, -1)
    return min(f, h)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}