import "container/heap"

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

func totalCost(costs []int, k int, candidates int) int64 {
	n := len(costs)
	leftHeap := &IntHeap{}
	rightHeap := &IntHeap{}
	heap.Init(leftHeap)
	heap.Init(rightHeap)

	for i := 0; i < candidates && i < n; i++ {
		heap.Push(leftHeap, costs[i])
	}

	for i := max(candidates, n-candidates); i < n; i++ {
		heap.Push(rightHeap, costs[i])
	}

	left := candidates
	right := n - candidates - 1
	totalCost := int64(0)

	for i := 0; i < k; i++ {
		if leftHeap.Len() == 0 {
			totalCost += int64(heap.Pop(rightHeap).(int))
		} else if rightHeap.Len() == 0 {
			totalCost += int64(heap.Pop(leftHeap).(int))
		} else if (*leftHeap)[0] <= (*rightHeap)[0] {
			totalCost += int64(heap.Pop(leftHeap).(int))
			if left <= right {
				heap.Push(leftHeap, costs[left])
				left++
			}
		} else {
			totalCost += int64(heap.Pop(rightHeap).(int))
			if left <= right {
				heap.Push(rightHeap, costs[right])
				right--
			}
		}
	}

	return totalCost
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}