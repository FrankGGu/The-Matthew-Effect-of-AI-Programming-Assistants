type Graph struct {
    adj [][]int
}

func Constructor(n int, edges [][]int) Graph {
    adj := make([][]int, n)
    for i := range adj {
        adj[i] = make([]int, n)
        for j := range adj[i] {
            adj[i][j] = -1
        }
    }
    for _, edge := range edges {
        from, to, cost := edge[0], edge[1], edge[2]
        adj[from][to] = cost
    }
    return Graph{adj: adj}
}

func (this *Graph) AddEdge(edge []int) {
    from, to, cost := edge[0], edge[1], edge[2]
    this.adj[from][to] = cost
}

func (this *Graph) ShortestPath(node1 int, node2 int) int {
    n := len(this.adj)
    dist := make([]int, n)
    for i := range dist {
        dist[i] = math.MaxInt32
    }
    dist[node1] = 0
    heap := &MinHeap{}
    heap.Push([]int{node1, 0})

    for heap.Len() > 0 {
        current := heap.Pop().([]int)
        u, currentDist := current[0], current[1]
        if u == node2 {
            return currentDist
        }
        if currentDist > dist[u] {
            continue
        }
        for v := 0; v < n; v++ {
            if this.adj[u][v] != -1 {
                newDist := dist[u] + this.adj[u][v]
                if newDist < dist[v] {
                    dist[v] = newDist
                    heap.Push([]int{v, newDist})
                }
            }
        }
    }
    return -1
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
    *h = old[0 : n-1]
    return x
}