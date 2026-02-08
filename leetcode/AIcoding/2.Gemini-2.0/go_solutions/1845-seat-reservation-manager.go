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

type SeatManager struct {
	available IntHeap
	next      int
}

func Constructor(n int) SeatManager {
	return SeatManager{
		available: IntHeap{},
		next:      1,
	}
}

func (this *SeatManager) Reserve() int {
	if this.available.Len() > 0 {
		seat := heap.Pop(&this.available).(int)
		return seat
	} else {
		seat := this.next
		this.next++
		return seat
	}
}

func (this *SeatManager) Unreserve(seatNumber int) {
	heap.Push(&this.available, seatNumber)
}