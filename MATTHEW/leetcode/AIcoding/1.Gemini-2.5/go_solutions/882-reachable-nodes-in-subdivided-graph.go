import (
	"container/heap"
	"math"
)

type Item struct {
	node     int
	distance int64 // Distance to this node from the source
	index    int   // The index of the item in the heap
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	// We want Pop to give us the item with the lowest distance
	return pq[i].distance < pq[j].distance
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].index = i
	pq[j].index = j
}

func (pq *PriorityQueue) Push(x any) {
	n := len(*pq)
	item := x.(*Item)
	item.index = n
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() any {
	old := *pq
	n := len(old)
	item := old[n-1]
	old[n-1] = nil // Avoid memory leak
	item.index = -1 // For safety, item is no longer in the heap
	*pq = old[0 : n-1]
	return item
}

func reachableNodes(edges [][]int, maxMoves int, n int) int {
	// Build adjacency list for the graph where edge weights are (number of subdivided nodes + 1)
	adj := make([][]struct {
		to     int
		weight int64
	}, n)
	for _, edge := range edges {
		u, v, count := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], struct {
			to     int
			weight int64
		}{v, int64(count) + 1})
		adj[v] = append(adj[v], struct {
			to     int
			weight int64
		}{u, int64(count) + 1})
	}

	// Initialize distances for Dijkstra's algorithm
	dist := make([]int64, n)
	for i := range dist {
		dist[i] = math.MaxInt64 // Use MaxInt64 for infinity
	}
	dist[0] = 0 // Starting node is 0

	// Initialize priority queue
	pq := make(PriorityQueue, 0)
	heap.Init(&pq)
	heap.Push(&pq, &Item{node: 0, distance: 0})

	// Run Dijkstra's algorithm
	for pq.Len() > 0 {
		item := heap.Pop(&pq).(*Item)
		u := item.node
		d := item.distance

		// If we found a shorter path to u already, skip this one
		if d > dist[u] {
			continue
		}

		// Explore neighbors
		for _, edge := range adj[u] {
			v := edge.to
			weight := edge.weight
			if dist[u]+weight < dist[v] {
				dist[v] = dist[u] + weight
				heap.Push(&pq, &Item{node: v, distance: dist[v]})
			}
		}
	}

	// Calculate total reachable nodes
	ans := int64(0)

	// Count original nodes reachable within maxMoves
	for i := 0; i < n; i++ {
		if dist[i] <= int64(maxMoves) {
			ans++
		}
	}

	// Count subdivided nodes reachable
	for _, edge := range edges {
		u, v, count := edge[0], edge[1], edge[2]

		// Calculate how many steps remaining from u and v
		// max(0, ...) handles cases where dist[u] or dist[v] > maxMoves
		reachableFromU := max64(0, int64(maxMoves)-dist[u])
		reachableFromV := max64(0, int64(maxMoves)-dist[v])

		// The total new nodes reachable on this edge is the sum of what's reachable
		// from both ends, capped by the total number of new nodes (count)
		ans += min64(int64(count), reachableFromU+reachableFromV)
	}

	return int(ans)
}

func max64(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func min64(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}