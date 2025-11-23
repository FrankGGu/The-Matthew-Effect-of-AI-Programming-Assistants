import (
	"container/heap"
	"math"
)

type Item struct {
	node int
	dist int
}

type MinHeap []Item

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].dist < h[j].dist }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Item))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func networkDelayTime(times [][]int, n int, k int) int {
	adj := make([][][2]int, n)
	for _, time := range times {
		u, v, w := time[0]-1, time[1]-1, time[2]
		adj[u] = append(adj[u], [2]int{v, w})
	}

	dist := make([]int, n)
	for i := range dist {
		dist[i] = math.MaxInt32
	}
	dist[k-1] = 0

	h := &MinHeap{}
	heap.Init(h)
	heap.Push(h, Item{node: k - 1, dist: 0})

	for h.Len() > 0 {
		item := heap.Pop(h).(Item)
		currNode := item.node
		currDist := item.dist

		if currDist > dist[currNode] {
			continue
		}

		for _, edge := range adj[currNode] {
			nextNode := edge[0]
			weight := edge[1]

			if dist[currNode]+weight < dist[nextNode] {
				dist[nextNode] = dist[currNode] + weight
				heap.Push(h, Item{node: nextNode, dist: dist[nextNode]})
			}
		}
	}

	maxDelay := 0
	for _, d := range dist {
		if d == math.MaxInt32 {
			return -1
		}
		if d > maxDelay {
			maxDelay = d
		}
	}

	return maxDelay
}