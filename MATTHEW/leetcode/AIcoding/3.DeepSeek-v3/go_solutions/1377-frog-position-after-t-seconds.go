func frogPosition(n int, edges [][]int, t int, target int) float64 {
    adj := make([][]int, n+1)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    visited := make([]bool, n+1)
    prob := make([]float64, n+1)
    prob[1] = 1.0
    q := []int{1}
    visited[1] = true

    for time := 0; time < t && len(q) > 0; time++ {
        size := len(q)
        for i := 0; i < size; i++ {
            u := q[0]
            q = q[1:]

            children := 0
            for _, v := range adj[u] {
                if !visited[v] {
                    children++
                }
            }

            for _, v := range adj[u] {
                if !visited[v] {
                    visited[v] = true
                    prob[v] = prob[u] / float64(children)
                    q = append(q, v)
                }
            }

            if children > 0 {
                prob[u] = 0.0
            }
        }
    }

    return prob[target]
}