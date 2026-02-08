import (
	"container/heap"
	"math"
)

type Item struct {
	node  int
	dist  int
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
	old[n-1] = nil
	item.index = -1
	*pq = old[0 : n-1]
	return item
}

func networkDelayTime(times [][]int, n int, k int) int {
	adj := make([][][2]int, n+1)
	for _, time := range times {
		u, v, w := time[0], time[1], time[2]
		adj[u] = append(adj[u], [2]int{v, w})
	}

	dist := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dist[i] = math.MaxInt32
	}
	dist[k] = 0

	pq := make(PriorityQueue, 0)
	heap.Push(&pq, &Item{node: k, dist: 0})

	for pq.Len() > 0 {
		item := heap.Pop(&pq).(*Item)
		u := item.node
		d := item.dist

		if d > dist[u] {
			continue
		}

		for _, edge := range adj[u] {
			v, weight := edge[0], edge[1]
			if dist[u]+weight < dist[v] {
				dist[v] = dist[u] + weight
				heap.Push(&pq, &Item{node: v, dist: dist[v]})
			}
		}
	}

	maxTime := 0
	for i := 1; i <= n; i++ {
		if dist[i] == math.MaxInt32 {
			return -1
		}
		if dist[i] > maxTime {
			maxTime = dist[i]
		}
	}

	return maxTime
}