import (
	"container/heap"
	"sort"
)

type Edge struct {
	U, V, Weight int
}

type MaxHeap []Edge

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].Weight > h[j].Weight }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(Edge))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximumWeightedSubset(n int, edges [][]int, k int) int64 {
	h := &MaxHeap{}
	heap.Init(h)

	for _, edge := range edges {
		u, v, weight := edge[0], edge[1], edge[2]
		heap.Push(h, Edge{U: u, V: v, Weight: weight})
	}

	var totalWeight int64 = 0
	removedEdges := 0

	for h.Len() > 0 && removedEdges < k {
		edge := heap.Pop(h).(Edge)
		totalWeight += int64(edge.Weight)
		removedEdges++
	}

	remainingEdges := []Edge{}
	for h.Len() > 0 {
		remainingEdges = append(remainingEdges, heap.Pop(h).(Edge))
	}

	sort.Slice(remainingEdges, func(i, j int) bool {
		return remainingEdges[i].Weight > remainingEdges[j].Weight
	})

	for _, edge := range remainingEdges {
		totalWeight += int64(edge.Weight)
	}

	return totalWeight
}