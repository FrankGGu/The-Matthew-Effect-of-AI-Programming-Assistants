import (
	"container/heap"
	"math"
)

type Edge struct {
	to     int
	weight int
}

type State struct {
	node   int
	weight int
}

type PriorityQueue []State

func (pq PriorityQueue) Len() int           { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].weight < pq[j].weight }
func (pq PriorityQueue) Swap(i, j int)      { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(State))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func countPaths(n int, roads [][]int) int {
	mod := int(1e9 + 7)
	graph := make([][]Edge, n)
	for _, road := range roads {
		u, v, time := road[0], road[1], road[2]
		graph[u] = append(graph[u], Edge{v, time})
		graph[v] = append(graph[v], Edge{u, time})
	}

	dist := make([]int, n)
	ways := make([]int, n)
	for i := 0; i < n; i++ {
		dist[i] = math.MaxInt32
	}
	dist[0] = 0
	ways[0] = 1

	pq := &PriorityQueue{}
	heap.Push(pq, State{0, 0})

	for pq.Len() > 0 {
		current := heap.Pop(pq).(State)
		node := current.node
		currentDist := current.weight

		if currentDist > dist[node] {
			continue
		}

		for _, edge := range graph[node] {
			nextNode := edge.to
			newDist := currentDist + edge.weight

			if newDist < dist[nextNode] {
				dist[nextNode] = newDist
				ways[nextNode] = ways[node]
				heap.Push(pq, State{nextNode, newDist})
			} else if newDist == dist[nextNode] {
				ways[nextNode] = (ways[nextNode] + ways[node]) % mod
			}
		}
	}

	return ways[n-1]
}