func pathExists(n int, edges [][]int, queries [][]int) []bool {
    adj := make([][]int, n)
    for _, edge := range edges {
        adj[edge[0]] = append(adj[edge[0]], edge[1])
        adj[edge[1]] = append(adj[edge[1]], edge[0])
    }

    result := make([]bool, len(queries))
    for i, query := range queries {
        start := query[0]
        end := query[1]
        visited := make([]bool, n)
        queue := []int{start}
        visited[start] = true
        found := false

        for len(queue) > 0 {
            curr := queue[0]
            queue = queue[1:]

            if curr == end {
                found = true
                break
            }

            for _, neighbor := range adj[curr] {
                if !visited[neighbor] {
                    visited[neighbor] = true
                    queue = append(queue, neighbor)
                }
            }
        }

        result[i] = found
    }

    return result
}