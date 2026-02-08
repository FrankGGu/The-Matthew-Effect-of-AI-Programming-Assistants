type SeatManager struct {
    availableSeats *IntHeap
}

func Constructor(n int) SeatManager {
    h := &IntHeap{}
    for i := 1; i <= n; i++ {
        heap.Push(h, i)
    }
    return SeatManager{availableSeats: h}
}

func (this *SeatManager) Reserve() int {
    return heap.Pop(this.availableSeats).(int)
}

func (this *SeatManager) Unreserve(seatNumber int) {
    heap.Push(this.availableSeats, seatNumber)
}

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