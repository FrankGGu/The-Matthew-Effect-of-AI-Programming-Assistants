package main

import "container/heap"

type appleHeap [][2]int // [expire_day, count]

func (h appleHeap) Len() int { return len(h) }
func (h appleHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h appleHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *appleHeap) Push(x interface{}) {
	*h = append(*h, x.([2]int))
}

func (h *appleHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func eatenApples(apples []int, days []int) int {
	h := &appleHeap{}
	heap.Init(h)
	eaten := 0
	day := 0

	for day < len(apples) || h.Len() > 0 {
		// Add today's apples
		if day < len(apples) && apples[day] > 0 {
			expire := day + days[day]
			heap.Push(h, [2]int{expire, apples[day]})
		}

		// Remove expired apples
		for h.Len() > 0 && (*h)[0][0] <= day {
			heap.Pop(h)
		}

		// Eat an apple
		if h.Len() > 0 {
			min := (*h)[0]
			if min[1] > 0 {
				min[1]--
				eaten++
				if min[1] == 0 {
					heap.Pop(h)
				} else {
					heap.Fix(h, 0)
				}
			}
		}

		day++
	}

	return eaten
}