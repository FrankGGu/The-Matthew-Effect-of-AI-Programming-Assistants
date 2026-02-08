package main

import (
    "container/heap"
)

type Item struct {
    value string
    count int
}

type MaxHeap []Item

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].count > h[j].count }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(Item))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    item := old[n-1]
    *h = old[0 : n-1]
    return item
}

func topKFrequent(nums []int, k int) []int {
    frequency := make(map[int]int)
    for _, num := range nums {
        frequency[num]++
    }

    h := &MaxHeap{}
    heap.Init(h)
    for num, count := range frequency {
        heap.Push(h, Item{value: num, count: count})
    }

    result := make([]int, 0, k)
    for i := 0; i < k; i++ {
        item := heap.Pop(h).(Item)
        result = append(result, item.value)
    }
    return result
}