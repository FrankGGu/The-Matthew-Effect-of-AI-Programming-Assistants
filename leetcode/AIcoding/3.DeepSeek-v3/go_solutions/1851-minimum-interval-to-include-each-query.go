import (
	"container/heap"
	"sort"
)

type IntervalHeap [][]int

func (h IntervalHeap) Len() int { return len(h) }
func (h IntervalHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h IntervalHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }
func (h *IntervalHeap) Push(x interface{}) { *h = append(*h, x.([]int)) }
func (h *IntervalHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

func minInterval(intervals [][]int, queries []int) []int {
	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][0] < intervals[j][0]
	})

	queriesWithIndex := make([][2]int, len(queries))
	for i, q := range queries {
		queriesWithIndex[i] = [2]int{q, i}
	}
	sort.Slice(queriesWithIndex, func(i, j int) bool {
		return queriesWithIndex[i][0] < queriesWithIndex[j][0]
	})

	h := &IntervalHeap{}
	heap.Init(h)
	res := make([]int, len(queries))
	i := 0

	for _, q := range queriesWithIndex {
		query, index := q[0], q[1]
		for i < len(intervals) && intervals[i][0] <= query {
			start, end := intervals[i][0], intervals[i][1]
			heap.Push(h, []int{end - start + 1, end})
			i++
		}

		for h.Len() > 0 && (*h)[0][1] < query {
			heap.Pop(h)
		}

		if h.Len() > 0 {
			res[index] = (*h)[0][0]
		} else {
			res[index] = -1
		}
	}

	return res
}