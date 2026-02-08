package main

import (
	"container/heap"
	"sort"
)

type Course struct {
	duration, lastDay int
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

func scheduleCourse(courses [][]int) int {
	n := len(courses)
	c := make([]Course, n)
	for i := 0; i < n; i++ {
		c[i] = Course{courses[i][0], courses[i][1]}
	}
	sort.Slice(c, func(i, j int) bool {
		return c[i].lastDay < c[j].lastDay
	})

	h := &MaxHeap{}
	totalTime := 0
	for _, course := range c {
		if totalTime+course.duration <= course.lastDay {
			totalTime += course.duration
			heap.Push(h, course.duration)
		} else if h.Len() > 0 && h.Len() > 0 && course.duration > (*h)[0] {
			totalTime += course.duration - (*h)[0]
			heap.Pop(h)
			heap.Push(h, course.duration)
		}
	}

	return h.Len()
}

func main() {}