import (
    "container/heap"
)

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func furthestBuilding(heights []int, bricks int, ladders int) int {
    minHeap := &MinHeap{}
    heap.Init(minHeap)

    for i := 0; i < len(heights)-1; i++ {
        diff := heights[i+1] - heights[i]
        if diff <= 0 {
            continue
        }

        if minHeap.Len() < ladders {
            heap.Push(minHeap, diff)
        } else {
            if ladders > 0 && diff > (*minHeap)[0] {
                bricks -= heap.Pop(minHeap).(int)
                heap.Push(minHeap, diff)
            } else {
                bricks -= diff
            }

            if bricks < 0 {
                return i
            }
        }
    }

    return len(heights) - 1
}