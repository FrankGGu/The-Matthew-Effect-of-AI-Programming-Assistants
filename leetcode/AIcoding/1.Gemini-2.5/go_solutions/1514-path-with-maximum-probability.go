import (
	"container/heap"
)

type Item struct {
	prob float64
	node int
}

type PriorityQueue []Item

func (pq PriorityQueue) Len() int {
	return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
	// We want a max-heap based on probability, so we use > instead of <.
	return pq[i].prob > pq[j].prob
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

func maxProbability(n int, edges [][]int, succProb []float64, start int, end int) float64 {
	graph := make([][]struct {
		to   int
		prob float64
	}, n)

	for i, edge := range edges {
		u, v := edge[0], edge[1]
		p := succProb[i]
		graph[u] = append(graph[u], struct {
			to   int
			prob float64
		}{v, p})
		graph[v] = append(graph[v], struct {
			to   int
			prob float64
		}{u, p})
	}

	maxProb := make([]float64, n)
	maxProb[start] = 1.0

	pq := make(PriorityQueue, 0)
	heap.Init(&pq)
	heap.Push(&pq, Item{prob: 1.0, node: start})

	for pq.Len() > 0 {
		item := heap.Pop(&pq).(Item)
		currentProb, u := item.prob, item.node

		// If we've already found a better path to 'u', skip this one.
		// Due to floating point precision, a small tolerance might be needed in general
		// but for this problem, direct comparison usually works.
		if currentProb < maxProb[u] {
			continue
		}

		for _, edge := range graph[u] {
			v, edgeProb := edge.to, edge.prob
			newProb := currentProb * edgeProb

			if newProb > maxProb[v] {
				maxProb[v] = newProb
				heap.Push(&pq, Item{prob: newProb, node: v})
			}
		}
	}

	return maxProb[end]
}