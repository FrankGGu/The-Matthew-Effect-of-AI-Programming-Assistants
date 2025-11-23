package main

func connectSticks(sticks []int) int {
    if len(sticks) <= 1 {
        return 0
    }

    minHeap := sticks
    heap.Init(&minHeap)

    totalCost := 0

    for len(minHeap) > 1 {
        first := heap.Pop(&minHeap).(int)
        second := heap.Pop(&minHeap).(int)
        cost := first + second
        totalCost += cost
        heap.Push(&minHeap, cost)
    }

    return totalCost
}

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}