type Project struct {
	capital int
	profit  int
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] =