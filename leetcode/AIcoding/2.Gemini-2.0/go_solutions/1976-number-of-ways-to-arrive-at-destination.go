import "container/heap"

type Pair struct {
	Node int
	Dist int
}

type PriorityQueue []Pair

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Dist < pq[j].Dist
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Pair)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func countPaths(n int, roads [][]int) int {
	graph := make([][]Pair, n)
	for _, road := range roads {
		u, v, w := road[0], road[1], road[2]
		graph[u] = append(graph[u], Pair{v, w})
		graph[v] = append(graph[v], Pair{u, w})
	}

	dist := make([]int, n)
	ways := make([]int, n)
	for i := range dist {
		dist[i] = 1 << 62
		ways[i] = 0
	}

	dist[0] = 0
	ways[0] = 1

	pq := &PriorityQueue{{0, 0}}
	heap.Init(pq)

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(Pair)
		u, d := curr.Node, curr.Dist

		if d > dist[u] {
			continue
		}

		for _, neighbor := range graph[u] {
			v, w := neighbor.Node, neighbor.Dist
			if dist[v] > dist[u]+w {
				dist[v] = dist[u] + w
				ways[v] = ways[u]
				heap.Push(pq, Pair{v, dist[v]})
			} else if dist[v] == dist[u]+w {
				ways[v] = (ways[v] + ways[u]) % (1e9 + 7)
			}
		}
	}

	return ways[n-1]
}