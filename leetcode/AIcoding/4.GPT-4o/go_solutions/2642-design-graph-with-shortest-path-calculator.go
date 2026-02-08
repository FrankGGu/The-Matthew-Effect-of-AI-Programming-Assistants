type Graph struct {
    edges map[int]map[int]int
}

func Constructor() Graph {
    return Graph{edges: make(map[int]map[int]int)}
}

func (g *Graph) AddEdge(u int, v int, w int) {
    if g.edges[u] == nil {
        g.edges[u] = make(map[int]int)
    }
    g.edges[u][v] = w
    if g.edges[v] == nil {
        g.edges[v] = make(map[int]int)
    }
    g.edges[v][u] = w
}

func (g *Graph) ShortestPath(source int, target int) int {
    dist := make(map[int]int)
    for node := range g.edges {
        dist[node] = int(^uint(0) >> 1) // Initialize to infinity
    }
    dist[source] = 0
    pq := make([][2]int, 0)
    heap.Push(&pq, [2]int{0, source})

    for len(pq) > 0 {
        d, node := heap.Pop(&pq).([2]int)[0], heap.Pop(&pq).([2]int)[1]
        if d > dist[node] {
            continue
        }
        for neighbor, weight := range g.edges[node] {
            if newDist := dist[node] + weight; newDist < dist[neighbor] {
                dist[neighbor] = newDist
                heap.Push(&pq, [2]int{newDist, neighbor})
            }
        }
    }

    if dist[target] == int(^uint(0)>>1) {
        return -1
    }
    return dist[target]
}