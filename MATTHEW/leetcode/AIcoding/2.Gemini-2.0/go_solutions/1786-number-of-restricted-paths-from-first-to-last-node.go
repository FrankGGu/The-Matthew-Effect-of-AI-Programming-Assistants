import (
	"container/heap"
	"math"
)

func countRestrictedPaths(n int, edges [][]int) int {
	graph := make([][]int, n+1)
	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		graph[u] = append(graph[u], (v<<16)|w)
		graph[v] = append(graph[v], (u<<16)|w)
	}

	dist := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dist[i] = math.MaxInt32
	}
	dist[n] = 0

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, &Item{value: n, priority: 0})

	for pq.Len() > 0 {
		item := heap.Pop(pq).(*Item)
		u := item.value
		d := item.priority

		if d > dist[u] {
			continue
		}

		for _, edge := range graph[u] {
			v := edge >> 16
			w := edge & 0xFFFF
			if dist[v] > dist[u]+w {
				dist[v] = dist[u] + w
				heap.Push(pq, &Item{value: v, priority: dist[v]})
			}
		}
	}

	dp := make([]int, n+1)
	dp[n] = 1
	var dfs func(int) int
	dfs = func(u int) int {
		if dp[u] != 0 {
			return dp[u]
		}
		count := 0
		for _, edge := range graph[u] {
			v := edge >> 16
			if dist[v] < dist[u] {
				count = (count + dfs(v)) % 1000000007
			}
		}
		dp[u] = count
		return dp[u]
	}

	return dfs(1)
}

type Item struct {
	value    int
	priority int
	index    int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].priority < pq[j].priority
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