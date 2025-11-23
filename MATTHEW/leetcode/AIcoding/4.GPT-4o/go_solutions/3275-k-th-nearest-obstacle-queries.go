package main

import (
	"container/heap"
	"math"
)

type Query struct {
	x, y, index int
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func kNearestObstacles(rows int, cols int, obstacles [][]int, queries [][]int) []int {
	obsSet := make(map[[2]int]bool)
	for _, obs := range obstacles {
		obsSet[[2]int{obs[0], obs[1]}] = true
	}

	results := make([]int, len(queries))
	queriesWithIndex := make([]Query, len(queries))
	for i, q := range queries {
		queriesWithIndex[i] = Query{q[0], q[1], i}
	}

	heap.Init(&MaxHeap{})
	for i := 0; i < len(queries); i++ {
		closest := make(MaxHeap, 0)
		for r := 0; r < rows; r++ {
			for c := 0; c < cols; c++ {
				if obsSet[[2]int{r, c}] {
					distance := int(math.Abs(float64(queriesWithIndex[i].x-r))) + int(math.Abs(float64(queriesWithIndex[i].y-c)))
					heap.Push(&closest, distance)
					if closest.Len() > i+1 {
						heap.Pop(&closest)
					}
				}
			}
		}
		if closest.Len() > 0 {
			results[queriesWithIndex[i].index] = closest.Len() > i ? closest[i] : -1
		} else {
			results[queriesWithIndex[i].index] = -1
		}
	}
	return results
}