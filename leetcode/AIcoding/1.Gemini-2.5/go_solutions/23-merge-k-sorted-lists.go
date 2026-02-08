type ListNode struct {
	Val  int
	Next *ListNode
}

type minHeap []*ListNode

func (h minHeap) Len() int {
	return len(h)
}

func (h minHeap) Less(i, j int) bool {
	return h[i].Val < h[j].Val
}

func (h minHeap) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}

func (h *minHeap) Push(x interface{}) {
	node := x.(*ListNode)
	*h = append(*h, node)
}

func (h *minHeap) Pop() interface{} {
	old := *h
	n := len(old)
	node := old[n-1]
	*h = old[0 : n-1]
	return node
}

func mergeKLists(lists []*ListNode) *ListNode {
	mh := &minHeap{}
	heap.Init(mh)

	for _, list := range lists {
		if list != nil {
			heap.Push(mh, list)
		}
	}

	dummyHead := &ListNode{}
	current := dummyHead

	for mh.Len() > 0 {
		minNode := heap.Pop(mh).(*ListNode)
		current.Next = minNode
		current = current.Next

		if minNode.Next != nil {
			heap.Push(mh, minNode.Next)
		}
	}

	return dummyHead.Next
}