func furthestBuilding(heights []int, bricks int, ladders int) int {
    minHeap := &minHeap{}
    for i := 0; i < len(heights)-1; i++ {
        diff := heights[i+1] - heights[i]
        if diff > 0 {
            heap.Push(minHeap, diff)
            bricks -= diff
        }
        if bricks < 0 {
            if ladders > 0 {
                bricks += heap.Pop(minHeap).(int)
                ladders--
            } else {
                return i
            }
        }
    }
    return len(heights) - 1
}

type minHeap []int

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *minHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *minHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}