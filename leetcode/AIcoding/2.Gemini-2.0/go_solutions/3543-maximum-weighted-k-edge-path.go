import (
	"container/heap"
	"math"
)

type Edge struct {
	To     int
	Weight int
}

type Item struct {
	Node  int
	Dist  int
	Edges int
}

type PriorityQueue []Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	if pq[i].Dist != pq[j].Dist {
		return pq[i].Dist < pq[j].Dist
	}
	return pq[i].Edges < pq[j].Edges
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Item)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func maxWeightKEdgePath(n int, edges [][]int, src int, dest int, k int) int {
	adj := make([][]Edge, n)
	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], Edge{To: v, Weight: w})
	}

	dist := make([][]int, n)
	for i := 0; i < n; i++ {
		dist[i] = make([]int, k+1)
		for j := 0; j <= k; j++ {
			dist[i][j] = math.MaxInt32
		}
	}

	dist[src][0] = 0

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, Item{Node: src, Dist: 0, Edges: 0})

	for pq.Len() > 0 {
		item := heap.Pop(pq).(Item)
		u := item.Node
		d := item.Dist
		e := item.Edges

		if d > dist[u][e] {
			continue
		}

		if u == dest && e == k {
			return d
		}

		for _, edge := range adj[u] {
			v := edge.To
			w := edge.Weight

			if e+1 <= k {
				if dist[v][e+1] > d+w {
					dist[v][e+1] = d + w
					heap.Push(pq, Item{Node: v, Dist: dist[v][e+1], Edges: e + 1})
				}
			}
		}
	}

	return -1
}