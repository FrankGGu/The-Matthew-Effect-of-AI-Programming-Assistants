import (
	"container/heap"
	"math"
)

type Edge struct {
	to     int
	weight int
}

type PriorityQueue []Edge

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].weight < pq[j].weight
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Edge)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func minCostConnectPoints(points [][]int) int {
	n := len(points)
	adj := make([][]Edge, n)
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			weight := int(math.Abs(float64(points[i][0]-points[j][0])) + math.Abs(float64(points[i][1]-points[j][1])))
			adj[i] = append(adj[i], Edge{to: j, weight: weight})
			adj[j] = append(adj[j], Edge{to: i, weight: weight})
		}
	}

	visited := make([]bool, n)
	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, Edge{to: 0, weight: 0})

	mstCost := 0
	edgesUsed := 0

	for edgesUsed < n {
		edge := heap.Pop(pq).(Edge)
		to := edge.to
		weight := edge.weight

		if visited[to] {
			continue
		}

		visited[to] = true
		mstCost += weight
		edgesUsed++

		for _, neighbor := range adj[to] {
			if !visited[neighbor.to] {
				heap.Push(pq, neighbor)
			}
		}
	}

	return mstCost
}