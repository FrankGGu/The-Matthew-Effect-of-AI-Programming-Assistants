func findEdges(n int, edges [][]int, src int, dst int) []bool {
    adj := make([][][2]int, n)
    for _, e := range edges {
        u, v, w := e[0], e[1], e[2]
        adj[u] = append(adj[u], [2]int{v, w})
        adj[v] = append(adj[v], [2]int{u, w})
    }

    dist := make([]int, n)
    for i := range dist {
        dist[i] = math.MaxInt32
    }
    dist[src] = 0
    heap := &Heap{}
    heap.Push([2]int{src, 0})

    for heap.Len() > 0 {
        node := heap.Pop().([2]int)
        u, d := node[0], node[1]
        if d > dist[u] {
            continue
        }
        for _, edge := range adj[u] {
            v, w := edge[0], edge[1]
            if dist[v] > dist[u]+w {
                dist[v] = dist[u] + w
                heap.Push([2]int{v, dist[v]})
            }
        }
    }

    if dist[dst] == math.MaxInt32 {
        return make([]bool, len(edges))
    }

    adj2 := make([][][3]int, n)
    for i, e := range edges {
        u, v, w := e[0], e[1], e[2]
        adj2[u] = append(adj2[u], [3]int{v, w, i})
        adj2[v] = append(adj2[v], [3]int{u, w, i})
    }

    res := make([]bool, len(edges))
    q := []int{dst}
    visited := make([]bool, n)
    visited[dst] = true

    for len(q) > 0 {
        u := q[0]
        q = q[1:]
        for _, edge := range adj2[u] {
            v, w, idx := edge[0], edge[1], edge[2]
            if dist[v]+w == dist[u] {
                res[idx] = true
                if !visited[v] {
                    visited[v] = true
                    q = append(q, v)
                }
            }
        }
    }

    return res
}

type Heap [][2]int

func (h Heap) Len() int           { return len(h) }
func (h Heap) Less(i, j int) bool { return h[i][1] < h[j][1] }
func (h Heap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *Heap) Push(x interface{}) { *h = append(*h, x.([2]int)) }
func (h *Heap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}