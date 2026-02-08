import "container/heap"

func totalCost(costs []int, k int, candidates int) int64 {
    n := len(costs)
    if n == 0 || k == 0 {
        return 0
    }

    left, right := 0, n-1
    minHeap := &minHeap{}

    for i := 0; i < candidates && left <= right; i++ {
        heap.Push(minHeap, costs[left])
        left++
    }

    for i := 0; i < candidates && left <= right; i++ {
        heap.Push(minHeap, costs[right])
        right--
    }

    totalCost := int64(0)

    for i := 0; i < k; i++ {
        if minHeap.Len() == 0 {
            break
        }
        cost := heap.Pop(minHeap).(int)
        totalCost += int64(cost)

        if left <= right {
            heap.Push(minHeap, costs[left])
            left++
        } else if right >= left {
            heap.Push(minHeap, costs[right])
            right--
        }
    }

    return totalCost
}

type minHeap []int

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *minHeap) Push(x any) {
    *h = append(*h, x.(int))
}

func (h *minHeap) Pop() any {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}