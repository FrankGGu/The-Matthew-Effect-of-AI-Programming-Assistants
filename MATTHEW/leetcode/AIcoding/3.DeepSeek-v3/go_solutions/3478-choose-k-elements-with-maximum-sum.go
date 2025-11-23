func maxKelements(nums []int, k int) int64 {
    maxHeap := &MaxHeap{}
    heap.Init(maxHeap)
    for _, num := range nums {
        heap.Push(maxHeap, num)
    }

    var sum int64
    for i := 0; i < k; i++ {
        if maxHeap.Len() == 0 {
            break
        }
        num := heap.Pop(maxHeap).(int)
        sum += int64(num)
        newNum := (num + 2) / 3 // Equivalent to ceil(num / 3)
        heap.Push(maxHeap, newNum)
    }
    return sum
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
    *h = old[:n-1]
    return x
}