import "container/heap"

type Graph struct {
	n     int
	edges [][]int
}

func Constructor(n int, edges [][]int) Graph {
	return Graph{n: n, edges: edges}
}

func (this *Graph) AddEdge(edge []int) {
	this.edges = append(this.edges, edge)
}

func (this *Graph) ShortestPath(node1 int, node2 int) int {
	dist := make([]int, this.n)
	for i := 0; i < this.n; i++ {
		dist[i] = 1 << 30
	}
	dist[node1] = 0

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, &Item{value: node1, priority: 0})

	for pq.Len() > 0 {
		item := heap.Pop(pq).(*Item)
		u := item.value
		d := item.priority

		if d > dist[u] {
			continue
		}

		for _, edge := range this.edges {
			if edge[0] == u {
				v := edge[1]
				weight := edge[2]
				if dist[v] > dist[u] + weight {
					dist[v] = dist[u] + weight
					heap.Push(pq, &Item{value: v, priority: dist[v]})
				}
			}
		}
	}

	if dist[node2] == 1 << 30 {
		return -1
	}
	return dist[node2]
}

type Item struct {
	value    int
	priority int
	index    int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].priority < pq[j].priority
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].index = i
	pq[j].index = j
}

func (pq *PriorityQueue) Push(x interface{}) {
	n := len(*pq)
	item := x.(*Item)
	item.index = n
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	old[n-1] = nil  // avoid memory leak
	item.index = -1 // for safety
	*pq = old[0 : n-1]
	return item
}