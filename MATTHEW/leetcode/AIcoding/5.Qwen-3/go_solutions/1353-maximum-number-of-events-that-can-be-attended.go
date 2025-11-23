package main

func maxEvents(events [][]int) int {
    sort.Slice(events, func(i, j int) bool {
        return events[i][1] < events[j][1]
    })

    heap := []int{}
    idx := 0
    count := 0

    for i := 1; i <= 100000; i++ {
        for idx < len(events) && events[idx][0] <= i {
            heappush(&heap, events[idx][1])
            idx++
        }

        for len(heap) > 0 && heap[0] < i {
            heappop(&heap)
        }

        if len(heap) > 0 {
            heappop(&heap)
            count++
        }
    }

    return count
}

type intHeap []int

func (h intHeap) Len() int           { return len(h) }
func (h intHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h intHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *intHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *intHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func heappush(h *intHeap, x int) {
    heap.Push(h, x)
}

func heappop(h *intHeap) {
    heap.Pop(h)
}