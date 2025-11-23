import (
    "container/heap"
    "math"
)

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

func minimumDeviation(nums []int) int {
    maxHeap := &MaxHeap{}
    minVal := math.MaxInt32

    for _, num := range nums {
        if num%2 == 0 {
            heap.Push(maxHeap, num)
            if num < minVal {
                minVal = num
            }
        } else {
            heap.Push(maxHeap, num*2)
            if num*2 < minVal {
                minVal = num * 2
            }
        }
    }

    minDeviation := math.MaxInt32

    for maxHeap.Len() > 0 {
        maxVal := heap.Pop(maxHeap).(int)
        minDeviation = min(minDeviation, maxVal-minVal)

        if maxVal%2 == 0 {
            maxVal /= 2
            heap.Push(maxHeap, maxVal)
            if maxVal < minVal {
                minVal = maxVal
            }
        } else {
            break
        }
    }

    return minDeviation
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}