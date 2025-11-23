import (
	"container/heap"
)

type CharCount struct {
	char  byte
	count int
}

type MaxHeap []CharCount

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].count > h[j].count }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(CharCount))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func reorganizeString(s string) string {
	count := make(map[byte]int)
	for i := 0; i < len(s); i++ {
		count[s[i]]++
	}

	maxHeap := &MaxHeap{}
	heap.Init(maxHeap)

	for char, cnt := range count {
		heap.Push(maxHeap, CharCount{char, cnt})
	}

	var res []byte
	var prev CharCount

	for maxHeap.Len() > 0 {
		curr := heap.Pop(maxHeap).(CharCount)
		res = append(res, curr.char)
		curr.count--

		if prev.count > 0 {
			heap.Push(maxHeap, prev)
		}

		prev = curr
	}

	if len(res) != len(s) {
		return ""
	}

	return string(res)
}