import (
	"container/heap"
	"math"
)

type Edge struct {
	To     int
	Weight int
}

type Node struct {
	Index    int
	Distance int
}

type PriorityQueue []Node

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Distance < pq[j].Distance
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Node)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func shortestPath(n int, edges [][]int, src int) []int {
	adj := make([][]Edge, n)
	for _, edge := range edges {
		u, v, weight := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], Edge{To: v, Weight: weight})
		adj[v] = append(adj[v], Edge{To: u, Weight: weight})
	}

	dist := make([]int, n)
	for i := range dist {
		dist[i] = math.MaxInt32
	}
	dist[src] = 0

	pq := &PriorityQueue{Node{Index: src, Distance: 0}}
	heap.Init(pq)

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(Node)
		u := curr.Index
		d := curr.Distance

		if d > dist[u] {
			continue
		}

		for _, edge := range adj[u] {
			v := edge.To
			weight := edge.Weight
			if dist[u]+weight < dist[v] {
				dist[v] = dist[u] + weight
				heap.Push(pq, Node{Index: v, Distance: dist[v]})
			}
		}
	}

	for i := range dist {
		if dist[i] == math.MaxInt32 {
			dist[i] = -1
		}
	}

	return dist
}