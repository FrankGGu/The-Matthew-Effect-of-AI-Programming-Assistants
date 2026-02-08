import (
	"sort"
)

func minInterval(intervals [][]int, queries []int) []int {
	n := len(intervals)
	m := len(queries)
	result := make([]int, m)
	for i := range result {
		result[i] = -1
	}

	type Query struct {
		Index int
		Value int
	}

	sortedQueries := make([]Query, m)
	for i := range queries {
		sortedQueries[i] = Query{Index: i, Value: queries[i]}
	}

	sort.Slice(sortedQueries, func(i, j int) bool {
		return sortedQueries[i].Value < sortedQueries[j].Value
	})

	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][0] < intervals[j][0]
	})

	h := &IntHeap{}
	availableIntervals := 0

	for _, query := range sortedQueries {
		for availableIntervals < n && intervals[availableIntervals][0] <= query.Value {
			interval := intervals[availableIntervals]
			length := interval[1] - interval[0] + 1
			heap.Push(h, []int{length, interval[1]})
			availableIntervals++
		}

		for h.Len() > 0 && (*h)[0][1] < query.Value {
			heap.Pop(h)
		}

		if h.Len() > 0 {
			result[query.Index] = (*h)[0][0]
		}
	}

	return result
}

import "container/heap"

type IntHeap [][]int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.([]int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}