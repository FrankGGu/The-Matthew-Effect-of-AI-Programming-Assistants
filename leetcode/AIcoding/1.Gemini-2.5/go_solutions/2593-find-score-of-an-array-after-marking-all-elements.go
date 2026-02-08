import (
	"container/heap"
)

type Pair struct {
	val int
	idx int
}

type MinHeap []Pair

func (h MinHeap) Len() int { return len(h) }
func (h MinHeap) Less(i, j int) bool {
	if h[i].val != h[j].val {
		return h[i].val < h[j].val
	}
	return h[i].idx < h[j].idx
}
func (h MinHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Pair))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func findScore(nums []int) int64 {
	n := len(nums)
	if n == 0 {
		return 0
	}

	h := &MinHeap{}
	heap.Init(h)

	for i := 0; i < n; i++ {
		heap.Push(h, Pair{val: nums[i], idx: i})
	}

	var score int64
	marked := make([]bool, n)

	for h.Len() > 0 {
		p := heap.Pop(h).(Pair)
		val := p.val
		idx := p.idx

		if marked[idx] {
			continue
		}

		score += int64(val)
		marked[idx] = true
		if idx-1 >= 0 {
			marked[idx-1] = true
		}
		if idx+1 < n {
			marked[idx+1] = true
		}
	}

	return score
}