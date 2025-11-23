func maximumScoreAfterOperations(edges [][]int, values []int) int64 {
    n := len(values)
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    var dfs func(u, parent int) (int64, int64)
    dfs = func(u, parent int) (int64, int64) {
        total := int64(0)
        minDeleted := int64(0)
        isLeaf := true
        for _, v := range adj[u] {
            if v != parent {
                childTotal, childMinDeleted := dfs(v, u)
                total += childTotal
                minDeleted += childMinDeleted
                isLeaf = false
            }
        }
        if isLeaf {
            return int64(values[u]), 0
        }
        currentVal := int64(values[u])
        if currentVal + minDeleted > total {
            return currentVal + minDeleted, minDeleted
        } else {
            return total, total - currentVal
        }
    }

    totalSum, _ := dfs(0, -1)
    return totalSum
}