import (
	"container/heap"
)

type Item struct {
	char  rune
	count int
}

type MaxHeap []Item

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].count > h[j].count }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(Item))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func reorganizeString(s string) string {
	counts := make(map[rune]int)
	for _, r := range s {
		counts[r]++
	}

	h := &MaxHeap{}
	heap.Init(h)

	for char, count := range counts {
		heap.Push(h, Item{char: char, count: count})
	}

	result := ""
	var prev Item

	for h.Len() > 0 {
		item := heap.Pop(h).(Item)
		result += string(item.char)
		item.count--

		if prev.count > 0 {
			heap.Push(h, prev)
		}

		prev = item
	}

	if len(result) != len(s) {
		return ""
	}

	return result
}