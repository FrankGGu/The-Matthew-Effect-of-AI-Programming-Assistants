import (
	"container/heap"
	"sort"
)

func countOfPairs(n int, m int, roads [][]int) []int {
	adj := make([][]int, n+1)
	for _, road := range roads {
		u, v, w := road[0], road[1], road[2]
		adj[u] = append(adj[u], v*1000000000+w)
		adj[v] = append(adj[v], u*1000000000+w)
	}

	dist := make([][]int, n+1)
	for i := 1; i <= n; i++ {
		dist[i] = dijkstra(n, i, adj)
	}

	ans := make([]int, 2*n+1)
	for i := 1; i <= n; i++ {
		for j := i + 1; j <= n; j++ {
			ans[dist[i][j]]++
		}
	}

	res := make([]int, n)
	for i := 1; i < n; i++ {
		res[i] = ans[i]
	}
	return res
}

type Item struct {
	node     int
	distance int
}

type PriorityQueue []Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].distance < pq[j].distance
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

func dijkstra(n int, start int, adj [][]int) []int {
	distances := make([]int, n+1)
	for i := 1; i <= n; i++ {
		distances[i] = 1e18
	}
	distances[start] = 0

	pq := make(PriorityQueue, 0)
	heap.Push(&pq, Item{node: start, distance: 0})

	for pq.Len() > 0 {
		item := heap.Pop(&pq).(Item)
		u := item.node
		d := item.distance

		if d > distances[u] {
			continue
		}

		for _, edge := range adj[u] {
			v := edge / 1000000000
			w := edge % 1000000000
			if distances[v] > distances[u]+w {
				distances[v] = distances[u] + w
				heap.Push(&pq, Item{node: v, distance: distances[v]})
			}
		}
	}
	return distances
}