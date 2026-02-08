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

type SmallestInfiniteSet struct {
	set map[int]bool
	pq  IntHeap
	cur int
}

func Constructor() SmallestInfiniteSet {
	return SmallestInfiniteSet{
		set: make(map[int]bool),
		pq:  IntHeap{},
		cur: 1,
	}
}

func (this *SmallestInfiniteSet) PopSmallest() int {
	if this.pq.Len() > 0 {
		val := heap.Pop(&this.pq).(int)
		delete(this.set, val)
		return val
	}
	this.cur++
	return this.cur - 1
}

func (this *SmallestInfiniteSet) AddBack(num int) {
	if num < this.cur && !this.set[num] {
		heap.Push(&this.pq, num)
		this.set[num] = true
	}
}