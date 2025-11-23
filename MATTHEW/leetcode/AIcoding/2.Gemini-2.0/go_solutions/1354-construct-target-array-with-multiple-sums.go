import (
	"container/heap"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] }
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

func isPossible(target []int) bool {
	sum := 0
	h := &IntHeap{}
	heap.Init(h)
	for _, num := range target {
		sum += num
		heap.Push(h, num)
	}

	for {
		largest := heap.Pop(h).(int)
		restSum := sum - largest

		if largest == 1 || restSum == 1 {
			return true
		}

		if largest <= restSum || restSum == 0 {
			return false
		}

		prev := largest % restSum

		if prev == 0 {
			return false
		}

		heap.Push(h, prev)
		sum = restSum + prev
	}
}