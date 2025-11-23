package main

import (
	"container/heap"
)

type Item struct {
	val  int // The current sum
	sIdx int // Index in the 'prevSums' slice (from the previous iteration)
	xIdx int // Index in the current row 'mat[i]'
}

type MinHeap []Item

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].val < h[j].val }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Item))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func kthSmallestSum(mat [][]int, k int) int {
	mRows := len(mat)
	nCols := len(mat[0])

	// Initialize 'prevSums' with a single sum of 0.
	// This allows us to process the first row in the same way as subsequent rows.
	prevSums := []int{0}

	// Iterate through each row of the matrix
	for i := 0; i < mRows; i++ {
		currentRow := mat[i]

		h := &MinHeap{}
		heap.Init(h)

		// For each sum 'sVal' from 'prevSums', we can form new sums by adding
		// elements from 'currentRow'. The smallest sum for each 'sVal' is
		// 'sVal + currentRow[0]'. We push these initial smallest combinations
		// into the min-heap.
		for sIdx, sVal := range prevSums {
			// Since rows are sorted, currentRow[0] is the smallest element.
			// Only push if currentRow has elements (nCols >= 1, which is guaranteed by constraints).
			heap.Push(h, Item{val: sVal + currentRow[0], sIdx: sIdx, xIdx: 0})
		}

		// 'newPrevSums' will store the k smallest sums found after processing 'currentRow'.
		newPrevSums := make([]int, 0, k)

		// Extract the k smallest sums from the heap.
		// The loop continues as long as we need more sums (len < k) and the heap is not empty.
		for len(newPrevSums) < k && h.Len() > 0 {
			item := heap.Pop(h).(Item)
			newPrevSums = append(newPrevSums, item.val)

			// If there's a next element in the 'currentRow' for the current 'sVal'
			// (i.e., we haven't exhausted elements from 'currentRow' for this 'sVal'),
			// push the next possible sum into the heap.
			if item.xIdx+1 < nCols {
				nextXIdx := item.xIdx + 1
				nextVal := prevSums[item.sIdx] + currentRow[nextXIdx]
				heap.Push(h, Item{val: nextVal, sIdx: item.sIdx, xIdx: nextXIdx})
			}
		}
		// Update 'prevSums' for the next iteration.
		prevSums = newPrevSums
	}

	// After processing all rows, 'prevSums' contains the k smallest sums.
	// The k-th smallest sum is at index k-1.
	return prevSums[k-1]
}