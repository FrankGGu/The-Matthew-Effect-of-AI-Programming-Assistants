func minimumTime(n int, edges [][]int, disappear []int) []int {
    adj := make([][][2]int, n)
    for _, e := range edges {
        u, v, w := e[0], e[1], e[2]
        adj[u] = append(adj[u], [2]int{v, w})
        adj[v] = append(adj[v], [2]int{u, w})
    }

    dist := make([]int, n)
    for i := 0; i < n; i++ {
        dist[i] = math.MaxInt32
    }
    dist[0] = 0

    heap := &minHeap{}
    heap.Push([2]int{0, 0})

    for heap.Len() > 0 {
        current := heap.Pop().([2]int)
        u, time := current[0], current[1]
        if time > dist[u] {
            continue
        }
        for _, neighbor := range adj[u] {
            v, w := neighbor[0], neighbor[1]
            newTime := time + w
            if newTime < dist[v] && newTime < disappear[v] {
                dist[v] = newTime
                heap.Push([2]int{v, newTime})
            }
        }
    }

    res := make([]int, n)
    for i := 0; i < n; i++ {
        if dist[i] < disappear[i] {
            res[i] = dist[i]
        } else {
            res[i] = -1
        }
    }
    return res
}

type minHeap [][2]int

func (h *minHeap) Len() int           { return len(*h) }
func (h *minHeap) Less(i, j int) bool { return (*h)[i][1] < (*h)[j][1] }
func (h *minHeap) Swap(i, j int)      { (*h)[i], (*h)[j] = (*h)[j], (*h)[i] }
func (h *minHeap) Push(x interface{}) { *h = append(*h, x.([2]int)) }
func (h *minHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}