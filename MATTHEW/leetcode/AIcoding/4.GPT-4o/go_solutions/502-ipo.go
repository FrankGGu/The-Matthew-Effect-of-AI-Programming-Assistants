package main

import (
    "container/heap"
    "sort"
)

type Project struct {
    id       int
    capital  int
    profit   int
}

type MaxHeap []Project

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].profit > h[j].profit }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(Project))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func findMaximizedCapital(k int, w int, profits []int, capital []int) int {
    projects := make([]Project, len(profits))
    for i := 0; i < len(profits); i++ {
        projects[i] = Project{i, capital[i], profits[i]}
    }
    sort.Slice(projects, func(i, j int) bool {
        return projects[i].capital < projects[j].capital
    })

    maxHeap := &MaxHeap{}
    heap.Init(maxHeap)

    j := 0
    for i := 0; i < k; i++ {
        for j < len(projects) && projects[j].capital <= w {
            heap.Push(maxHeap, projects[j])
            j++
        }
        if maxHeap.Len() == 0 {
            break
        }
        w += heap.Pop(maxHeap).(Project).profit
    }
    return w
}