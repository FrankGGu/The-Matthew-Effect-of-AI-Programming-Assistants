import (
	"container/heap"
	"math"
)

type Edge struct {
	To     int
	Cost   int
	Blocks int
}

type Node struct {
	Vertex int
	Cost   int
	Blocks int
}

type PriorityQueue []Node

func (pq PriorityQueue) Len() int {
	return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
	if pq[i].Cost != pq[j].Cost {
		return pq[i].Cost < pq[j].Cost
	}
	return pq[i].Blocks < pq[j].Blocks
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

func minCost(maxTime int, edges [][]int, passingFees []int) int {
	n := len(passingFees)
	adj := make([][]Edge, n)
	for _, edge := range edges {
		u, v, time := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], Edge{To: v, Cost: passingFees[v], Blocks: time})
		adj[v] = append(adj[v], Edge{To: u, Cost: passingFees[u], Blocks: time})
	}

	dist := make([][]int, n)
	for i := range dist {
		dist[i] = make([]int, maxTime+1)
		for j := range dist[i] {
			dist[i][j] = math.MaxInt32
		}
	}

	dist[0][0] = passingFees[0]
	pq := &PriorityQueue{{Vertex: 0, Cost: passingFees[0], Blocks: 0}}
	heap.Init(pq)

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(Node)
		u, cost, blocks := curr.Vertex, curr.Cost, curr.Blocks

		if cost > dist[u][blocks] {
			continue
		}

		if u == n-1 {
			return cost
		}

		for _, edge := range adj[u] {
			v, newCost, newBlocks := edge.To, cost+edge.Cost, blocks+edge.Blocks
			if newBlocks <= maxTime && newCost < dist[v][newBlocks] {
				dist[v][newBlocks] = newCost
				heap.Push(pq, Node{Vertex: v, Cost: newCost, Blocks: newBlocks})
			}
		}
	}

	return -1
}