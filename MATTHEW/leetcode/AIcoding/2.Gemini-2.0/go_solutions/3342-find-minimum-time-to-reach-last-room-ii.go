import (
	"container/heap"
	"sort"
)

func minimumTime(times [][]int, capacity int) int64 {
	n := len(times)
	sort.Slice(times, func(i, j int) bool {
		return times[i][0] < times[j][0]
	})

	adj := make([][]int, n)
	for i := 0; i < n; i++ {
		adj[i] = make([]int, 0)
	}

	for i := 0; i < n-1; i++ {
		adj[i] = append(adj[i], i+1)
	}

	dist := make([]int64, n)
	for i := 0; i < n; i++ {
		dist[i] = -1
	}

	dist[0] = 0

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, &Item{value: 0, priority: 0})

	for pq.Len() > 0 {
		item := heap.Pop(pq).(*Item)
		u := item.value
		d := item.priority

		if d > dist[u] && dist[u] != -1 {
			continue
		}

		for _, v := range adj[u] {
			wait := int64(0)
			if dist[u]%int64(times[u][1]+times[u][0]) >= int64(times[u][0]) {
				wait = int64(times[u][1] + times[u][0]) - dist[u]%int64(times[u][1]+times[u][0])
			}

			newDist := dist[u] + wait + int64(times[u][0])

			if dist[v] == -1 || newDist < dist[v] {
				dist[v] = newDist
				heap.Push(pq, &Item{value: v, priority: dist[v]})
			}
		}

		if u > 0 {
			wait := int64(0)
			if dist[u]%int64(times[u][1]+times[u][0]) >= int64(times[u][0]) {
				wait = int64(times[u][1] + times[u][0]) - dist[u]%int64(times[u][1]+times[u][0])
			}

			newDist := dist[u] + wait + int64(times[u][0])

			if dist[u-1] == -1 || newDist < dist[u-1] {
				dist[u-1] = newDist
				heap.Push(pq, &Item{value: u-1, priority: dist[u-1]})
			}
		}
	}

	return dist[n-1]
}

type Item struct {
	value    int
	priority int64
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
	old[n-1] = nil
	item.index = -1
	*pq = old[0 : n-1]
	return item
}