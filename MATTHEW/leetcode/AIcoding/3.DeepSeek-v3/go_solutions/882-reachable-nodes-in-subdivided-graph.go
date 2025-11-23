func reachableNodes(edges [][]int, maxMoves int, n int) int {
    graph := make([][]pair, n)
    for _, edge := range edges {
        u, v, cnt := edge[0], edge[1], edge[2]
        graph[u] = append(graph[u], pair{v, cnt + 1})
        graph[v] = append(graph[v], pair{u, cnt + 1})
    }

    dist := make([]int, n)
    for i := range dist {
        dist[i] = math.MaxInt32
    }
    dist[0] = 0
    heap := &minHeap{}
    heap.Push(pair{0, 0})

    for heap.Len() > 0 {
        curr := heap.Pop().(pair)
        u := curr.node
        if curr.dist > dist[u] {
            continue
        }
        for _, neighbor := range graph[u] {
            v := neighbor.node
            newDist := dist[u] + neighbor.dist
            if newDist < dist[v] {
                dist[v] = newDist
                heap.Push(pair{v, newDist})
            }
        }
    }

    res := 0
    for i := 0; i < n; i++ {
        if dist[i] <= maxMoves {
            res++
        }
    }

    for _, edge := range edges {
        u, v, cnt := edge[0], edge[1], edge[2]
        a := max(0, maxMoves-dist[u])
        b := max(0, maxMoves-dist[v])
        res += min(a+b, cnt)
    }

    return res
}

type pair struct {
    node, dist int
}

type minHeap []pair

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i].dist < h[j].dist }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *minHeap) Push(x interface{}) {
    *h = append(*h, x.(pair))
}

func (h *minHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}