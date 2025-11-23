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

	dist1 := dijkstra(n, src1, adj)
	dist2 := dijkstra(n, src2, adj)
	distDest := dijkstra(n, dest, revAdj)

	ans := int64(math.MaxInt64)
	for i := 0; i < n; i++ {
		if dist1[i] != math.MaxInt64 && dist2[i] != math.MaxInt64 && distDest[i] != math.MaxInt64 {
			ans = min(ans, int64(dist1[i]+dist2[i]+distDest[i]))
		}
	}

	if ans == int64(math.MaxInt64) {
		return -1
	}
	return ans
}

func dijkstra(n int, start int, adj [][][]int) []int {
	dist := make([]int, n)
	for i := range dist {
		dist[i] = math.MaxInt64
	}
	dist[start] = 0

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, &Item{vertex: start, distance: 0})

	for pq.Len() > 0 {
		item := heap.Pop(pq).(*Item)
		u := item.vertex
		d := item.distance

		if d > dist[u] {
			continue
		}

		for _, edge := range adj[u] {
			v, w := edge[0], edge[1]
			if dist[u]+w < dist[v] {
				dist[v] = dist[u] + w
				heap.Push(pq, &Item{vertex: v, distance: dist[v]})
			}
		}
	}

	return dist
}

type Item struct {
	vertex   int
	distance int
	index    int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].distance < pq[j].distance
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

func main() {}