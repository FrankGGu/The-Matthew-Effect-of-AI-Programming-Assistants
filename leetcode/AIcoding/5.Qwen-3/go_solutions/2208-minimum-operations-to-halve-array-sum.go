package main

func minOperations(nums []int) int {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    target := sum / 2
    maxHeap := &MaxHeap{}
    for _, num := range nums {
        heap.Push(maxHeap, num)
    }
    operations := 0
    currentSum := sum
    for currentSum > target {
        maxVal := heap.Pop(maxHeap).(int)
        currentSum -= maxVal
        maxVal /= 2
        currentSum += maxVal
        heap.Push(maxHeap, maxVal)
        operations++
    }
    return operations
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}