package main

import (
	"container/heap"
)

type IntMinHeap []int

func (h IntMinHeap) Len() int           { return len(h) }
func (h IntMinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntMinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntMinHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntMinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type DinnerPlates struct {
	capacity int
	stacks   [][]int
	// availableStacks stores indices of stacks that are not full, as a min-heap.
	availableStacks IntMinHeap
	// rightmostNonEmptyStack tracks the maximum index that ever had an element.
	// Used to optimize Pop() by avoiding iterating all stacks from the end.
	rightmostNonEmptyStack int
}

func Constructor(capacity int) DinnerPlates {
	dp := DinnerPlates{
		capacity:               capacity,
		stacks:                 make([][]int, 0),
		availableStacks:        make(IntMinHeap, 0),
		rightmostNonEmptyStack: -1,
	}
	heap.Init(&dp.availableStacks)
	return dp
}

func (dp *DinnerPlates) Push(val int) {
	stackIdx := -1
	for dp.availableStacks.Len() > 0 {
		idx := heap.Pop(&dp.availableStacks).(int)
		if idx < len(dp.stacks) && len(dp.stacks[idx]) < dp.capacity {
			stackIdx = idx
			break
		}
	}

	if stackIdx == -1 {
		stackIdx = len(dp.stacks)
		dp.stacks = append(dp.stacks, make([]int, 0, dp.capacity))
	}

	dp.stacks[stackIdx] = append(dp.stacks[stackIdx], val)

	if len(dp.stacks[stackIdx]) < dp.capacity {
		heap.Push(&dp.availableStacks, stackIdx)
	}

	if stackIdx > dp.rightmostNonEmptyStack {
		dp.rightmostNonEmptyStack = stackIdx
	}
}

func (dp *DinnerPlates) Pop() int {
	for dp.rightmostNonEmptyStack >= 0 && len(dp.stacks[dp.rightmostNonEmptyStack]) == 0 {
		dp.rightmostNonEmptyStack--
	}

	if dp.rightmostNonEmptyStack < 0 {
		return -1
	}

	stackIdx := dp.rightmostNonEmptyStack
	val := dp.stacks[stackIdx][len(dp.stacks[stackIdx])-1]
	dp.stacks[stackIdx] = dp.stacks[stackIdx][:len(dp.stacks[stackIdx])-1]

	heap.Push(&dp.availableStacks, stackIdx)

	return val
}

func (dp *DinnerPlates) PopAtStack(index int) int {
	if index < 0 || index >= len(dp.stacks) || len(dp.stacks[index]) == 0 {
		return -1
	}

	val := dp.stacks[index][len(dp.stacks[index])-1]
	dp.stacks[index] = dp.stacks[index][:len(dp.stacks[index])-1]

	heap.Push(&dp.availableStacks, index)

	return val
}