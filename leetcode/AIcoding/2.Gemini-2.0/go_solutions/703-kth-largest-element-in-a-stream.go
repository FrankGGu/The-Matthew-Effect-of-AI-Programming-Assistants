import "container/heap"

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
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

type KthLargest struct {
	k int
	h IntHeap
}

func Constructor(k int, nums []int) KthLargest {
	kl := KthLargest{k: k, h: IntHeap{}}
	heap.Init(&kl.h)
	for _, num := range nums {
		kl.Add(num)
	}
	return kl
}

func (this *KthLargest) Add(val int) int {
	heap.Push(&this.h, val)
	if this.h.Len() > this.k {
		heap.Pop(&this.h)
	}
	return this.h[0]
}