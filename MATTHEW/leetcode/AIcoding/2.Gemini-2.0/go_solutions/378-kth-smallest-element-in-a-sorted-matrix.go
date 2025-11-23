import "container/heap"

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

func kthSmallest(matrix [][]int, k int) int {
	n := len(matrix)
	h := &IntHeap{}
	heap.Init(h)

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			heap.Push(h, matrix[i][j])
			if h.Len() > k {
				heap.Pop(h)
			}
		}
	}

	return heap.Pop(h).(int)
}