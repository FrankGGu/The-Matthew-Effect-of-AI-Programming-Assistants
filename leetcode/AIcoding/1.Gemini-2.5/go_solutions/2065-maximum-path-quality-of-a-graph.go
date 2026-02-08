import (
	"container/heap"
	"math"
)

type item struct {
	value    int // The node ID
	priority int // The time (cost)
	index    int // The index in the heap array
}

type priorityQueue []*item

func (pq priorityQueue) Len() int { return len(pq) }
func (pq priorityQueue) Less(i, j int) bool {
	return pq[i].priority < pq[j].priority
}
func (pq priorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].index = i
	pq[j].index = j
}

func (pq *priorityQueue) Push(x any) {
	n := len(*pq)
	item := x.(*item)
	item.index = n
	*pq = append(*pq, item)
}

func (pq *priorityQueue) Pop() any {
	old := *pq
	n := len(old)
	item := old[n-1]
	old[n-1] = nil // avoid memory leak
	item.index = -1
	*pq = old[0 : n-1]
	return item
}

var maxQuality int
var adj map[int][][2]int // neighbor, time
var nodeValues []int
var maxAllowedTime int
var minTimeToZero []int // shortest time from node i to node 0

func dijkstra(n int, adj map[int][][2]int) []int {
	minTime := make([]int, n)
	for i := range minTime {
		minTime[i] = math.MaxInt32 // Initialize with infinity for unreachable nodes
	}

	pq := make(priorityQueue, 0)
	heap.Init(&pq)

	minTime[0] = 0
	heap.Push(&pq, &item{value: 0, priority: 0}) // (node, time)

	for pq.Len() > 0 {
		it := heap.Pop(&pq).(*item)
		u := it.value
		d := it.priority

		if d > minTime[u] { // Already found a shorter path
			continue
		}

		for _, edge := range adj[u] {
			v := edge[0]
			weight := edge[1]
			if minTime[v] > d+weight { // Strict inequality for update
				minTime[v] = d + weight
				heap.Push(&pq, &item{value: v, priority: d + weight})
			}
		}
	}
	return minTime
}

func dfs(node int, currentTime int, currentQuality int, visitedCounts []int) {
	// If this is the first time visiting 'node' on the current path, add its value.
	if visitedCounts[node] == 0 {
		currentQuality += nodeValues[node]
	}
	// Increment visit count for current node
	visitedCounts[node]++

	// Pruning: If node 0 is unreachable from 'node', or if current time plus
	// shortest time to node 0 exceeds maxAllowedTime, then this path cannot
	// validly end at node 0. Prune this branch.
	if minTimeToZero[node] == math.MaxInt32 || currentTime+minTimeToZero[node] > maxAllowedTime {
		visitedCounts[node]-- // Backtrack: decrement visit count
		return
	}

	// If we are at node 0, this is a valid path ending, update maxQuality
	if node == 0 {
		if currentQuality > maxQuality {
			maxQuality = currentQuality
		}
	}

	// Explore neighbors
	for _, edge := range adj[node] {
		neighbor := edge[0]
		travelTime := edge[1]

		if currentTime+travelTime <= maxAllowedTime {
			dfs(neighbor, currentTime+travelTime, currentQuality, visitedCounts)
		}
	}

	// Backtrack: decrement visit count
	visitedCounts[node]--
}

func maxPathQuality(values []int, edges [][]int, maxTime int) int {
	nodeValues = values
	maxAllowedTime = maxTime

	n := len(values)
	adj = make(map[int][][2]int)
	for _, edge := range edges {
		u, v, t := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], [2]int{v, t})
		adj[v] = append(adj[v], [2]int{u, t})
	}

	// Precompute shortest times from all nodes to node 0 using Dijkstra
	minTimeToZero = dijkstra(n, adj)

	maxQuality = 0 // Initialize global maxQuality
	visitedCounts := make([]int, n)

	// Start DFS from node 0.
	// Initial call: node 0, time 0, currentQuality 0 (will be updated for node 0 inside dfs)
	dfs(0, 0, 0, visitedCounts)

	return maxQuality
}