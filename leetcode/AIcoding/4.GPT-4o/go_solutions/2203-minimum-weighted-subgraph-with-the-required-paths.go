func minimumWeight(n int, edges [][]int, src1 int, src2 int, dest int) int {
    graph := make([][][2]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], [2]int{edge[1], edge[2]})
        graph[edge[1]] = append(graph[edge[1]], [2]int{edge[0], edge[2]})
    }

    dijkstra := func(start int) []int {
        dist := make([]int, n)
        for i := range dist {
            dist[i] = math.MaxInt32
        }
        dist[start] = 0
        pq := &PriorityQueue{}
        heap.Push(pq, &Item{start, 0})

        for pq.Len() > 0 {
            curr := heap.Pop(pq).(*Item)
            u := curr.value

            for _, edge := range graph[u] {
                v, weight := edge[0], edge[1]
                if dist[u]+weight < dist[v] {
                    dist[v] = dist[u] + weight
                    heap.Push(pq, &Item{v, dist[v]})
                }
            }
        }
        return dist
    }

    distFromSrc1 := dijkstra(src1)
    distFromSrc2 := dijkstra(src2)
    distFromDest := dijkstra(dest)

    minWeight := math.MaxInt32
    for u := 0; u < n; u++ {
        if distFromSrc1[u] != math.MaxInt32 && distFromSrc2[u] != math.MaxInt32 && distFromDest[u] != math.MaxInt32 {
            totalWeight := distFromSrc1[u] + distFromSrc2[u] + distFromDest[u]
            if totalWeight < minWeight {
                minWeight = totalWeight
            }
        }
    }

    if minWeight == math.MaxInt32 {
        return -1
    }
    return minWeight
}

type Item struct {
    value int
    priority int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int {
    return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].priority < pq[j].priority
}

func (pq PriorityQueue) Swap(i, j int) {
    pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
    item := x.(*Item)
    *pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    *pq = old[0 : n-1]
    return item
}