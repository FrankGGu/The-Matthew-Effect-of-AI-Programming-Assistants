import (
	"container/heap"
	"math"
)

func minimumWeight(n int, edges [][]int, src1 int, src2 int, dest int) int64 {
	adj := make([][][]int, n)
	revAdj := make([][][]int, n)

	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], []int{v, w})
		revAdj[v] = append(revAdj[v], []int{u, w})
	}

	dist1 := dijkstra(n, adj, src1)
	dist2 := dijkstra(n, adj, src2)
	distDest := dijkstra(n, revAdj, dest)

	ans := int64(math.MaxInt64)
	for i := 0; i < n; i++ {
		if dist1[i] == int64(math.MaxInt64) || dist2[i] == int64(math.MaxInt64) || distDest[i] == int64(math.MaxInt64) {
			continue
		}
		ans = min(ans, dist1[i]+dist2[i]+distDest[i])
	}

	if ans == int64(math.MaxInt64) {
		return -1
	}
	return ans
}

func dijkstra(n int, adj [][][]int, src int) []int64 {
	dist := make([]int64, n)
	for i := 0; i < n; i++ {
		dist[i] = int64(math.MaxInt64)
	}
	dist[src] = 0

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, &Item{node: src, dist: 0})

	for pq.Len() > 0 {
		item := heap.Pop(pq).(*Item)
		u := item.node
		d := item.dist

		if d > dist[u] {
			continue
		}

		for _, neighbor := range adj[u] {
			v, w := neighbor[0], neighbor[1]
			if dist[u]+int64(w) < dist[v] {
				dist[v] = dist[u] + int64(w)
				heap.Push(pq, &Item{node: v, dist: dist[v]})
			}
		}
	}

	return dist
}

type Item struct {
	node int
	dist int64
	index int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].dist < pq[j].dist
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

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}