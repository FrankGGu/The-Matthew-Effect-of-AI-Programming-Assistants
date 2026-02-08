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
	*h = old[:n-1]
	return x
}

func totalCost(costs []int, k int, candidates int) int64 {
	n := len(costs)
	leftHeap := &MinHeap{}
	rightHeap := &MinHeap{}
	heap.Init(leftHeap)
	heap.Init(rightHeap)

	left, right := 0, n-1
	for left < candidates && left <= right {
		heap.Push(leftHeap, costs[left])
		left++
	}
	for right >= n-candidates && right >= left {
		heap.Push(rightHeap, costs[right])
		right--
	}

	var total int64 = 0
	for k > 0 {
		var leftMin, rightMin int
		if leftHeap.Len() > 0 {
			leftMin = (*leftHeap)[0]
		} else {
			leftMin = 1 << 31
		}
		if rightHeap.Len() > 0 {
			rightMin = (*rightHeap)[0]
		} else {
			rightMin = 1 << 31
		}

		if leftMin <= rightMin {
			total += int64(leftMin)
			heap.Pop(leftHeap)
			if left <= right {
				heap.Push(leftHeap, costs[left])
				left++
			}
		} else {
			total += int64(rightMin)
			heap.Pop(rightHeap)
			if left <= right {
				heap.Push(rightHeap, costs[right])
				right--
			}
		}
		k--
	}
	return total
}