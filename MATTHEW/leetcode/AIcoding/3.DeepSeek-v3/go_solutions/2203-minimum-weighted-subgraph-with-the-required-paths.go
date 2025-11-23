func minimumWeight(n int, edges [][]int, src1 int, src2 int, dest int) int64 {
    const inf = 1 << 60

    buildGraph := func() [][][2]int {
        graph := make([][][2]int, n)
        for _, e := range edges {
            u, v, w := e[0], e[1], e[2]
            graph[u] = append(graph[u], [2]int{v, w})
        }
        return graph
    }

    dijkstra := func(start int, graph [][][2]int) []int64 {
        dist := make([]int64, n)
        for i := range dist {
            dist[i] = inf
        }
        dist[start] = 0
        heap := &minHeap{}
        heap.Push([2]int64{int64(start), 0})

        for heap.Len() > 0 {
            node := heap.Pop()
            u, d := int(node[0]), node[1]
            if d > dist[u] {
                continue
            }
            for _, edge := range graph[u] {
                v, w := edge[0], edge[1]
                if dist[v] > dist[u]+int64(w) {
                    dist[v] = dist[u] + int64(w)
                    heap.Push([2]int64{int64(v), dist[v]})
                }
            }
        }
        return dist
    }

    graph := buildGraph()
    revGraph := make([][][2]int, n)
    for _, e := range edges {
        u, v, w := e[0], e[1], e[2]
        revGraph[v] = append(revGraph[v], [2]int{u, w})
    }

    distSrc1 := dijkstra(src1, graph)
    distSrc2 := dijkstra(src2, graph)
    distDest := dijkstra(dest, revGraph)

    res := inf
    for i := 0; i < n; i++ {
        total := distSrc1[i] + distSrc2[i] + distDest[i]
        if total < res {
            res = total
        }
    }

    if res >= inf {
        return -1
    }
    return res
}

type minHeap [][2]int64

func (h *minHeap) Len() int           { return len(*h) }
func (h *minHeap) Less(i, j int) bool { return (*h)[i][1] < (*h)[j][1] }
func (h *minHeap) Swap(i, j int)      { (*h)[i], (*h)[j] = (*h)[j], (*h)[i] }
func (h *minHeap) Push(x interface{}) { *h = append(*h, x.([2]int64)) }
func (h *minHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}