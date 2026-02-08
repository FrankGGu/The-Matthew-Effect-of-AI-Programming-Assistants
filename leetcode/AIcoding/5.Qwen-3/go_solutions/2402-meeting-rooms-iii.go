package main

import (
	"sort"
)

func mostBooked(n int, meetings [][]int) int {
	sort.Slice(meetings, func(i, j int) bool {
		return meetings[i][0] < meetings[j][0]
	})

	available := make([]int, n)
	for i := range available {
		available[i] = i
	}

	heap := &Heap{}
	heap.Init()

	result := 0
	count := make([]int, n)

	for _, meeting := range meetings {
		start, end := meeting[0], meeting[1]

		for len(available) > 0 && heap.Len() > 0 && heap.Top().end <= start {
			room := heap.Pop().(int)
			available = append(available, room)
			sort.Ints(available)
		}

		if len(available) > 0 {
			room := available[0]
			available = available[1:]
			heap.Push(room, end)
			count[room]++
			if count[room] > count[result] || (count[room] == count[result] && room < result) {
				result = room
			}
		} else {
			room, endTime := heap.Pop().(int), heap.Top().end
			heap.Pop()
			heap.Push(room, endTime)
			count[room]++
			if count[room] > count[result] || (count[room] == count[result] && room < result) {
				result = room
			}
		}
	}

	return result
}

type Heap struct {
	data [][2]int
}

func (h *Heap) Len() int           { return len(h.data) }
func (h *Heap) Less(i, j int) bool { return h.data[i][1] < h.data[j][1] || (h.data[i][1] == h.data[j][1] && h.data[i][0] < h.data[j][0]) }
func (h *Heap) Swap(i, j int)      { h.data[i], h.data[j] = h.data[j], h.data[i] }

func (h *Heap) Top() (int, int) {
	return h.data[0][0], h.data[0][1]
}

func (h *Heap) Push(x interface{}) {
	item := x.([2]int)
	h.data = append(h.data, item)
}

func (h *Heap) Pop() interface{} {
	old := h.data
	n := len(old)
	item := old[n-1]
	h.data = old[0 : n-1]
	return item
}

func (h *Heap) Init() {
	h.data = make([][2]int, 0)
}