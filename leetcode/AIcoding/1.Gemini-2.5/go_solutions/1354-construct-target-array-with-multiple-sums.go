package main

import (
	"container/heap"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap
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

func isPossible(target []int) bool {
	if len(target) == 1 {
		return target[0] == 1
	}

	pq := &IntHeap{}
	heap.Init(pq)

	var sum int64
	for _, num := range target {
		heap.Push(pq, num)
		sum += int64(num)
	}

	for (*pq)[0] != 1 {
		maxVal := heap.Pop(pq).(int)

		sumOfOthers := sum - int64(maxVal)

		// If sumOfOthers is 0, it means there was only one element in the array.
		// Since maxVal is not 1 (checked by loop condition), it's impossible to reach [1].
		if sumOfOthers == 0 {
			return false
		}

		// The largest element (maxVal) must be strictly greater than the sum of the other elements (sumOfOthers)
		// for it to be a valid result of the forward operation.
		// If maxVal <= sumOfOthers, it's an impossible state.
		if int64(maxVal) <= sumOfOthers {
			return false
		}

		// Calculate the previous value using the modulo optimization.
		// This effectively reverses multiple steps in one go if maxVal is significantly larger than sumOfOthers.
		newVal := int(int64(maxVal) % sumOfOthers)

		// If newVal is 0, it means maxVal was a multiple of sumOfOthers.
		// In this specific case, the previous value should be sumOfOthers itself.
		// Example: if target was [6, 2], sum=8, maxVal=6, sumOfOthers=2.
		// 6 % 2 = 0. The previous value was 2.
		if newVal == 0 {
			newVal = int(sumOfOthers)
		}

		// Update the total sum for the next iteration.
		sum = sum - int64(maxVal) + int64(newVal)

		// Push the calculated previous value back into the priority queue.
		heap.Push(pq, newVal)
	}

	return true
}