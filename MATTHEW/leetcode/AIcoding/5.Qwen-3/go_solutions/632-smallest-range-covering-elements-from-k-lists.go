package main

type Node struct {
    val     int
    listIdx int
    next    *Node
}

func smallestRange(heads []*ListNode) []int {
    if len(heads) == 0 {
        return []int{}
    }

    minHeap := make([]*Node, 0)
    maxVal := heads[0].Val

    for i, head := range heads {
        node := &Node{
            val:     head.Val,
            listIdx: i,
        }
        if head.Next != nil {
            node.next = head.Next
        }
        minHeap = append(minHeap, node)
        if head.Val > maxVal {
            maxVal = head.Val
        }
    }

    heap.Init(&minHeap)

    result := []int{0, 0}
    rangeLength := math.MaxInt32

    for {
        current := heap.Pop(&minHeap).(*Node)
        if current.val == current.next.Val {
            break
        }

        if maxVal-current.val < rangeLength {
            rangeLength = maxVal - current.val
            result[0] = current.val
            result[1] = maxVal
        }

        if current.next != nil {
            newNode := &Node{
                val:     current.next.Val,
                listIdx: current.listIdx,
            }
            if current.next.Next != nil {
                newNode.next = current.next.Next
            }
            heap.Push(&minHeap, newNode)
            if newNode.val > maxVal {
                maxVal = newNode.val
            }
        } else {
            break
        }
    }

    return result
}

type minHeap []*Node

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i].val < h[j].val }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *minHeap) Push(x interface{}) {
    *h = append(*h, x.(*Node))
}

func (h *minHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}