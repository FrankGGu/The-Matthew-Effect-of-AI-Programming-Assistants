import (
    "container/heap"
    "sort"
)

func minOperations(nums []int) int {
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    halfSum := totalSum / 2
    maxHeap := &IntHeap{}
    for _, num := range nums {
        heap.Push(maxHeap, -num)
    }

    operations := 0
    currentSum := totalSum
    for currentSum > halfSum {
        maxNum := -heap.Pop(maxHeap).(int)
        currentSum -= maxNum / 2
        heap.Push(maxHeap, -(maxNum / 2))
        operations++
    }

    return operations
}

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