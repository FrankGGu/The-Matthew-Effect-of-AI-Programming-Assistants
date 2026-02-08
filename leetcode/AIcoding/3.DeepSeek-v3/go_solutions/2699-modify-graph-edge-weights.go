func modifiedGraphEdges(n int, edges [][]int, source int, destination int, target int) [][]int {
    adj := make([][][2]int, n)
    for i, e := range edges {
        u, v, w := e[0], e[1], e[2]
        adj[u] = append(adj[u], [2]int{v, i})
        adj[v] = append(adj[v], [2]int{u, i})
    }

    dist := make([]int, n)
    for i := range dist {
        dist[i] = math.MaxInt32
    }
    dist[source] = 0
    heap := &minHeap{}
    heap.Push([]int{0, source})

    for heap.Len() > 0 {
        top := heap.Pop().([]int)
        d, u := top[0], top[1]
        if d > dist[u] {
            continue
        }
        for _, pair := range adj[u] {
            v, idx := pair[0], pair[1]
            w := edges[idx][2]
            if w == -1 {
                continue
            }
            if dist[v] > d+w {
                dist[v] = d + w
                heap.Push([]int{dist[v], v})
            }
        }
    }

    if dist[destination] < target {
        return nil
    }
    if dist[destination] == target {
        for i := range edges {
            if edges[i][2] == -1 {
                edges[i][2] = 1
            }
        }
        return edges
    }

    found := false
    var parent []int
    var parentEdge []int
    var q [][2]int

    for i := 0; i < n; i++ {
        parent = make([]int, n)
        parentEdge = make([]int, n)
        for j := range parent {
            parent[j] = -1
            parentEdge[j] = -1
        }
        q = [][2]int{{i, 0}}
        parent[i] = i
        for len(q) > 0 {
            curr := q[0]
            u, d := curr[0], curr[1]
            q = q[1:]
            for _, pair := range adj[u] {
                v, idx := pair[0], pair[1]
                w := edges[idx][2]
                if w != -1 {
                    continue
                }
                if parent[v] == -1 {
                    parent[v] = u
                    parentEdge[v] = idx
                    q = append(q, [2]int{v, d + 1})
                }
            }
        }
        if parent[destination] != -1 {
            found = true
            break
        }
    }

    if !found {
        return nil
    }

    path := []int{destination}
    for path[len(path)-1] != source {
        path = append(path, parent[path[len(path)-1]])
    }
    for i, j := 0, len(path)-1; i < j; i, j = i+1, j-1 {
        path[i], path[j] = path[j], path[i]
    }

    total := 0
    for i := 0; i < len(path)-1; i++ {
        u, v := path[i], path[i+1]
        for _, pair := range adj[u] {
            if pair[0] == v {
                idx := pair[1]
                if edges[idx][2] != -1 {
                    total += edges[idx][2]
                }
                break
            }
        }
    }

    remaining := target - total
    if remaining < len(path)-1 {
        return nil
    }

    for i := 0; i < len(path)-1; i++ {
        u, v := path[i], path[i+1]
        for _, pair := range adj[u] {
            if pair[0] == v {
                idx := pair[1]
                if edges[idx][2] == -1 {
                    if i == len(path)-2 {
                        edges[idx][2] = remaining
                    } else {
                        edges[idx][2] = 1
                        remaining--
                    }
                }
                break
            }
        }
    }

    for i := range edges {
        if edges[i][2] == -1 {
            edges[i][2] = 1
        }
    }

    return edges
}

type minHeap [][]int

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *minHeap) Push(x interface{}) {
    *h = append(*h, x.([]int))
}
func (h *minHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}