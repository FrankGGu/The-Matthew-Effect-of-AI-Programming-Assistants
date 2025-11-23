import "container/heap"

type Edge struct {
    to, time int
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

func networkDelayTime(times [][]int, n int, k int) int {
    graph := make([][]Edge, n+1)
    for _, t := range times {
        graph[t[0]] = append(graph[t[0]], Edge{to: t[1], time: t[2]})
    }

    dist := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dist[i] = int(1e9)
    }
    dist[k] = 0

    minHeap := &MinHeap{}
    heap.Push(minHeap, []int{k, 0})

    for minHeap.Len() > 0 {
        u := heap.Pop(minHeap).([]int)[0]
        for _, edge := range graph[u] {
            v, time := edge.to, edge.time
            if dist[u]+time < dist[v] {
                dist[v] = dist[u] + time
                heap.Push(minHeap, []int{v, dist[v]})
            }
        }
    }

    maxDist := 0
    for i := 1; i <= n; i++ {
        if dist[i] == int(1e9) {
            return -1
        }
        if dist[i] > maxDist {
            maxDist = dist[i]
        }
    }
    return maxDist
}