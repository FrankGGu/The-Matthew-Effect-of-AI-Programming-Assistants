import (
	"container/heap"
	"math"
)

func secondMinimum(n int, edges [][]int, time int, change int) int {
	graph := make([][]int, n+1)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	dist := make([][]int, n+1)
	for i := 1; i <= n; i++ {
		dist[i] = []int{math.MaxInt32, math.MaxInt32}
	}
	dist[1][0] = 0

	pq := &PriorityQueue{}
	heap.Push(pq, &Item{node: 1, time: 0})

	for pq.Len() > 0 {
		item := heap.Pop(pq).(*Item)
		u := item.node
		t := item.time

		for _, v := range graph[u] {
			newTime := t
			cycle := newTime / change
			if cycle%2 == 1 {
				newTime += (change - (newTime % change))
			}
			newTime += time

			if newTime < dist[v][0] {
				dist[v][1] = dist[v][0]
				dist[v][0] = newTime
				heap.Push(pq, &Item{node: v, time: newTime})
			} else if newTime > dist[v][0] && newTime < dist[v][1] {
				dist[v][1] = newTime
				heap.Push(pq, &Item{node: v, time: newTime})
			}
		}
	}

	return dist[n][1]
}

type Item struct {
	node int
	time int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].time < pq[j].time
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*Item)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}