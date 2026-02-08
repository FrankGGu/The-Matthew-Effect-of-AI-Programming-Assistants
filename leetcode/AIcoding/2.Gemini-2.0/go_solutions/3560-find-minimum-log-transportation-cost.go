import (
	"container/heap"
	"math"
)

type Edge struct {
	To     int
	Cost   int
	Weight int
}

type Node struct {
	City int
	Cost int
}

type PriorityQueue []Node

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Cost < pq[j].Cost
}
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

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

func minCost(n int, roads [][]int, logs int) int {
	graph := make([][]Edge, n+1)
	for _, road := range roads {
		from, to, cost, weight := road[0], road[1], road[2], road[3]
		graph[from] = append(graph[from], Edge{To: to, Cost: cost, Weight: weight})
		graph[to] = append(graph[to], Edge{To: from, Cost: cost, Weight: weight})
	}

	dist := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dist[i] = math.MaxInt32
	}
	dist[1] = 0

	pq := &PriorityQueue{{City: 1, Cost: 0}}
	heap.Init(pq)

	for pq.Len() > 0 {
		node := heap.Pop(pq).(Node)
		u := node.City
		cost := node.Cost

		if cost > dist[u] {
			continue
		}

		for _, edge := range graph[u] {
			v := edge.To
			weight := edge.Weight
			edgeCost := edge.Cost

			newCost := cost + edgeCost*int(math.Ceil(float64(logs)/float64(weight)))

			if newCost < dist[v] {
				dist[v] = newCost
				heap.Push(pq, Node{City: v, Cost: newCost})
			}
		}
	}

	if dist[n] == math.MaxInt32 {
		return -1
	}
	return dist[n]
}