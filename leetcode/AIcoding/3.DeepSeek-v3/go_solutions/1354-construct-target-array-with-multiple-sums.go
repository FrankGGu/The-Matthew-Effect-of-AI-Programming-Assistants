import "container/heap"

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

func isPossible(target []int) bool {
    if len(target) == 1 {
        return target[0] == 1
    }

    h := &MaxHeap{}
    heap.Init(h)
    total := 0

    for _, num := range target {
        heap.Push(h, num)
        total += num
    }

    for {
        max := heap.Pop(h).(int)
        if max == 1 {
            return true
        }
        remaining := total - max
        if remaining == 0 || max <= remaining {
            return false
        }
        prev := max % remaining
        if remaining == 1 {
            prev = 1
        } else if prev == 0 {
            return false
        }
        heap.Push(h, prev)
        total = remaining + prev
    }
}