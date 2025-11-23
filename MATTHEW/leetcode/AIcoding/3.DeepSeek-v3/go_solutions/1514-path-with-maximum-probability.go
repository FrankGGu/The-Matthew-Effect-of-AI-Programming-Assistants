func maxProbability(n int, edges [][]int, succProb []float64, start int, end int) float64 {
    graph := make([][]pair, n)
    for i, edge := range edges {
        u, v := edge[0], edge[1]
        prob := succProb[i]
        graph[u] = append(graph[u], pair{v, prob})
        graph[v] = append(graph[v], pair{u, prob})
    }

    prob := make([]float64, n)
    prob[start] = 1.0
    heap := &maxHeap{}
    heap.Push(&pair{start, 1.0})

    for heap.Len() > 0 {
        curr := heap.Pop().(*pair)
        u := curr.node
        if u == end {
            return curr.prob
        }
        if curr.prob < prob[u] {
            continue
        }
        for _, neighbor := range graph[u] {
            v := neighbor.node
            nextProb := prob[u] * neighbor.prob
            if nextProb > prob[v] {
                prob[v] = nextProb
                heap.Push(&pair{v, nextProb})
            }
        }
    }

    return 0.0
}

type pair struct {
    node int
    prob float64
}

type maxHeap []*pair

func (h maxHeap) Len() int           { return len(h) }
func (h maxHeap) Less(i, j int) bool { return h[i].prob > h[j].prob }
func (h maxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *maxHeap) Push(x interface{}) {
    *h = append(*h, x.(*pair))
}

func (h *maxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}