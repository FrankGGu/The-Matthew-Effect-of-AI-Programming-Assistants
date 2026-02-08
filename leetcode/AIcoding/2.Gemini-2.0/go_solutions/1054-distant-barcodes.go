import "container/heap"

type pair struct {
	val   int
	count int
}

type maxHeap []pair

func (h maxHeap) Len() int           { return len(h) }
func (h maxHeap) Less(i, j int) bool { return h[i].count > h[j].count }
func (h maxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *maxHeap) Push(x interface{}) {
	*h = append(*h, x.(pair))
}

func (h *maxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func rearrangeBarcodes(barcodes []int) []int {
	counts := make(map[int]int)
	for _, barcode := range barcodes {
		counts[barcode]++
	}

	h := &maxHeap{}
	heap.Init(h)
	for val, count := range counts {
		heap.Push(h, pair{val: val, count: count})
	}

	result := make([]int, len(barcodes))
	for i := 0; i < len(barcodes); i++ {
		top := heap.Pop(h).(pair)
		result[i] = top.val
		top.count--
		if top.count > 0 {
			heap.Push(h, top)
		}
	}

	return result
}