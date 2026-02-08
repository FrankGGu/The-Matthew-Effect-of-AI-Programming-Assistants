import (
	"container/heap"
	"sort"
)

type Edge struct {
	x     int
	h     int
	isEnd bool
}

type Height struct {
	h   int
	idx int
}

type MaxHeap []Height

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].h > h[j].h }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(Height))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func getSkyline(buildings [][]int) [][]int {
	edges := []Edge{}
	for _, b := range buildings {
		edges = append(edges, Edge{b[0], b[2], false})
		edges = append(edges, Edge{b[1], b[2], true})
	}

	sort.Slice(edges, func(i, j int) bool {
		if edges[i].x != edges[j].x {
			return edges[i].x < edges[j].x
		}
		if edges[i].isEnd != edges[j].isEnd {
			return !edges[i].isEnd
		}
		if !edges[i].isEnd {
			return edges[i].h > edges[j].h
		}
		return edges[i].h < edges[j].h
	})

	h := &MaxHeap{}
	heap.Init(h)
	heap.Push(h, Height{0, -1})
	heights := map[int]int{-1: 0}

	result := [][]int{}
	prevHeight := 0

	for _, e := range edges {
		if !e.isEnd {
			heap.Push(h, Height{e.h, e.x})
			heights[e.x] = e.h
		} else {
			delete(heights, e.x)

		}

		for h.Len() > 0 {
			top := (*h)[0]
			if _, ok := heights[top.idx]; !ok && top.idx != -1 {
				heap.Pop(h)
			} else {
				break
			}
		}

		currentHeight := (*h)[0].h
		if currentHeight != prevHeight {
			result = append(result, []int{e.x, currentHeight})
			prevHeight = currentHeight
		}
	}

	return result
}