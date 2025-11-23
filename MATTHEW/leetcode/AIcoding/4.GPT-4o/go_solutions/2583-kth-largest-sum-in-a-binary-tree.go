import (
    "container/heap"
)

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

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
    *h = old[0 : n-1]
    return x
}

func kthLargestLevelSum(root *TreeNode, k int) int64 {
    if root == nil {
        return 0
    }

    levelSum := []int{}
    queue := []*TreeNode{root}

    for len(queue) > 0 {
        sum := 0
        levelSize := len(queue)
        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            sum += node.Val
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        levelSum = append(levelSum, sum)
    }

    h := &MinHeap{}
    heap.Init(h)

    for _, sum := range levelSum {
        heap.Push(h, sum)
        if h.Len() > k {
            heap.Pop(h)
        }
    }

    return int64((*h)[0])
}