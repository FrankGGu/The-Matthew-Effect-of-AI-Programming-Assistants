func maximumScore(scores []int, edges [][]int) int {
    n := len(scores)
    graph := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    for i := range graph {
        sort.Slice(graph[i], func(a, b int) bool {
            return scores[graph[i][a]] > scores[graph[i][b]]
        })
        if len(graph[i]) > 3 {
            graph[i] = graph[i][:3]
        }
    }

    maxScore := -1

    for _, e := range edges {
        u, v := e[0], e[1]
        for _, a := range graph[u] {
            if a == v {
                continue
            }
            for _, b := range graph[v] {
                if b == u || b == a {
                    continue
                }
                current := scores[u] + scores[v] + scores[a] + scores[b]
                if current > maxScore {
                    maxScore = current
                }
            }
        }
    }

    return maxScore
}