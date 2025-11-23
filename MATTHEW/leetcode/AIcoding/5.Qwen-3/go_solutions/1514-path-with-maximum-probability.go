package main

func maxProbability(n int, edges [][]int, successProbability []float64, start int, end int) float64 {
    graph := make([][]pair, n)
    for i := 0; i < len(edges); i++ {
        u, v := edges[i][0], edges[i][1]
        prob := successProbability[i]
        graph[u] = append(graph[u], pair{v, prob})
        graph[v] = append(graph[v], pair{u, prob})
    }

    dist := make([]float64, n)
    for i := 0; i < n; i++ {
        dist[i] = 0.0
    }
    dist[start] = 1.0

    heap := &maxHeap{}
    heap.push(node{start, 1.0})

    for heap.Len() > 0 {
        current := heap.pop()
        if current.id == end {
            return current.prob
        }
        if current.prob < dist[current.id] {
            continue
        }
        for _, neighbor := range graph[current.id] {
            newProb := current.prob * neighbor.prob
            if newProb > dist[neighbor.id] {
                dist[neighbor.id] = newProb
                heap.push(node{neighbor.id, newProb})
            }
        }
    }

    return 0.0
}

type pair struct {
    id   int
    prob float64
}

type node struct {
    id   int
    prob float64
}

type maxHeap []node

func (h maxHeap) Len() int           { return len(h) }
func (h maxHeap) Less(i, j int) bool { return h[i].prob > h[j].prob }
func (h maxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *maxHeap) Push(x interface{}) {
    *h = append(*h, x.(node))
}

func (h *maxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}