type Edge struct {
    to, rev int
}

func minEdgeReversals(n int, edges [][]int) int {
    graph := make([][]Edge, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], Edge{edge[1], 0})
        graph[edge[1]] = append(graph[edge[1]], Edge{edge[0], 1})
    }

    dist := make([]int, n)
    for i := 0; i < n; i++ {
        dist[i] = -1
    }
    dist[0] = 0

    queue := []int{0}
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        for _, edge := range graph[node] {
            if dist[edge.to] == -1 {
                dist[edge.to] = dist[node] + edge.rev
                queue = append(queue, edge.to)
            }
        }
    }

    maxRev := 0
    for _, d := range dist {
        if d == -1 {
            return -1
        }
        if d > maxRev {
            maxRev = d
        }
    }

    return maxRev
}