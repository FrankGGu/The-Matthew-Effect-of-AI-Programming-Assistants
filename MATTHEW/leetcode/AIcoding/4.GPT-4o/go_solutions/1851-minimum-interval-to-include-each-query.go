package main

import (
	"container/heap"
	"sort"
)

type Interval struct {
	start, end int
}

type Item struct {
	index, length int
}

type MinHeap []Item

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].length < h[j].length }
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

func minInterval(intervals [][]int, queries []int) []int {
	n := len(queries)
	res := make([]int, n)
	for i := range res {
		res[i] = -1
	}

	intervalsWithIndex := make([]Interval, len(intervals))
	for i, interval := range intervals {
		intervalsWithIndex[i] = Interval{interval[0], interval[1]}
	}

	sort.Slice(intervalsWithIndex, func(i, j int) bool {
		return intervalsWithIndex[i].start < intervalsWithIndex[j].start
	})

	queriesWithIndex := make([][2]int, n)
	for i, query := range queries {
		queriesWithIndex[i] = [2]int{query, i}
	}

	sort.Slice(queriesWithIndex, func(i, j int) bool {
		return queriesWithIndex[i][0] < queriesWithIndex[j][0]
	})

	h := &MinHeap{}
	for i, query := range queriesWithIndex {
		for len(intervalsWithIndex) > 0 && intervalsWithIndex[0].start <= query[0] {
			interval := intervalsWithIndex[0]
			heap.Push(h, Item{0, interval.end - interval.start + 1})
			intervalsWithIndex = intervalsWithIndex[1:]
		}

		for len(*h) > 0 {
			if (*h)[0].length < query[0]-(*h)[0].index {
				heap.Pop(h)
			} else {
				break
			}
		}

		if len(*h) > 0 {
			res[query[1]] = (*h)[0].length
		}
	}

	return res
}