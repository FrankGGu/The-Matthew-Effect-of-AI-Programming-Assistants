type Server struct {
    idx    int
    weight int
    freeAt int
}

type MinHeap []Server

func (h MinHeap) Len() int { return len(h) }
func (h MinHeap) Less(i, j int) bool {
    if h[i].freeAt == h[j].freeAt {
        if h[i].weight == h[j].weight {
            return h[i].idx < h[j].idx
        }
        return h[i].weight < h[j].weight
    }
    return h[i].freeAt < h[j].freeAt
}
func (h MinHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) { *h = append(*h, x.(Server)) }
func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}

func assignTasks(servers []int, tasks []int) []int {
    n := len(servers)
    m := len(tasks)
    res := make([]int, m)

    available := make(MinHeap, 0, n)
    for i := 0; i < n; i++ {
        heap.Push(&available, Server{i, servers[i], 0})
    }

    busy := make(MinHeap, 0)

    for t := 0; t < m; t++ {
        for busy.Len() > 0 && busy[0].freeAt <= t {
            s := heap.Pop(&busy).(Server)
            heap.Push(&available, s)
        }

        if available.Len() > 0 {
            s := heap.Pop(&available).(Server)
            res[t] = s.idx
            s.freeAt = t + tasks[t]
            heap.Push(&busy, s)
        } else {
            s := heap.Pop(&busy).(Server)
            res[t] = s.idx
            s.freeAt += tasks[t]
            heap.Push(&busy, s)
        }
    }

    return res
}