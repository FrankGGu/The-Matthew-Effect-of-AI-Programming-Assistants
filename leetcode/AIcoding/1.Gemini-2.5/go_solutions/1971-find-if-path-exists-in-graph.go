func validPath(n int, edges [][]int, start int, end int) bool {
    if start == end {
        return true
    }

    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    visited := make([]bool, n)
    queue := []int{start}
    visited[start] = true

    head := 0
    for head < len(queue) {
        u := queue[head]
        head++

        if u == end {
            return true
        }

        for _, v := range adj[u] {
            if !visited[v] {
                visited[v] = true
                queue = append(queue, v)
            }
        }
    }

    return false
}