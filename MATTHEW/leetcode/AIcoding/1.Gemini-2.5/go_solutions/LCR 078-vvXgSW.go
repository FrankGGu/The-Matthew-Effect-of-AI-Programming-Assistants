package main

import (
	"container/heap"
)

type ListNode struct {
	Val int
	Next *ListNode
}

type ListNodeHeap []*ListNode

func (h ListNodeHeap) Len() int           { return len(h) }
func (h ListNodeHeap) Less(i, j int) bool { return h[i].Val < h[j].Val }
func (h ListNodeHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *ListNodeHeap) Push(x any) {
	*h = append(*h, x.(*ListNode))
}

func (h *ListNodeHeap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func mergeKLists(lists []*ListNode) *ListNode {
	h := &ListNodeHeap{}
	heap.Init(h)

	for _, list := range lists {
		if list != nil {
			heap.Push(h, list)
		}
	}

	dummyHead := &ListNode{}
	current := dummyHead

	for h.Len() > 0 {
		minNode := heap.Pop(h).(*ListNode)
		current.Next = minNode
		current = current.Next
		if minNode.Next != nil {
			heap.Push(h, minNode.Next)
		}
	}

	return dummyHead.Next
}