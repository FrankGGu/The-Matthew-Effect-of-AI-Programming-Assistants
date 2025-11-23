type Edge struct {
    to, weight int
}

func shortestPathTree(n int, edges [][]int, start int) []int {
    adj := make([][]Edge, n)
    for _, e := range edges {
        u, v, w := e[0], e[1], e[2]
        adj[u] = append(adj[u], Edge{v, w})
        adj[v] = append(adj[v], Edge{u, w})
    }

    dist := make([]int, n)
    for i := range dist {
        dist[i] = math.MaxInt32
    }
    dist[start] = 0

    heap := &MinHeap{}
    heap.Push([]int{start, 0})

    for heap.Len() > 0 {
        node := heap.Pop()
        u, d := node[0], node[1]
        if d > dist[u] {
            continue
        }
        for _, edge := range adj[u] {
            v, w := edge.to, edge.weight
            if dist[v] > dist[u]+w {
                dist[v] = dist[u] + w
                heap.Push([]int{v, dist[v]})
            }
        }
    }

    return dist
}

type MinHeap [][]int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i][1] < h[j][1] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.([]int))
}
func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}