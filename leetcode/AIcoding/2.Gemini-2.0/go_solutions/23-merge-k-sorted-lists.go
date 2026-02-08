import "container/heap"

type ListNode struct {
	Val  int
	Next *ListNode
}

type PriorityQueue []*ListNode

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Val < pq[j].Val
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*ListNode)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	old[n-1] = nil // avoid memory leak
	*pq = old[0 : n-1]
	return item
}

func mergeKLists(lists []*ListNode) *ListNode {
	pq := &PriorityQueue{}
	heap.Init(pq)

	for _, list := range lists {
		if list != nil {
			heap.Push(pq, list)
		}
	}

	dummy := &ListNode{}
	tail := dummy

	for pq.Len() > 0 {
		node := heap.Pop(pq).(*ListNode)
		tail.Next = node
		tail = tail.Next
		if node.Next != nil {
			heap.Push(pq, node.Next)
		}
	}

	return dummy.Next
}