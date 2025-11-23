package main

type SeatManager struct {
    heap []int
}

func Constructor(n int) SeatManager {
    h := make([]int, 0, n)
    for i := 1; i <= n; i++ {
        h = append(h, i)
    }
    return SeatManager{heap: h}
}

func (this *SeatManager) Reserve() int {
    if len(this.heap) == 0 {
        return -1
    }
    res := this.heap[0]
    this.heap[0] = this.heap[len(this.heap)-1]
    this.heap = this.heap[:len(this.heap)-1]
    if len(this.heap) > 0 {
        this.heapify(0)
    }
    return res
}

func (this *SeatManager) Unreserve(seatNumber int) {
    this.heap = append(this.heap, seatNumber)
    this.bubbleUp(len(this.heap) - 1)
}

func (this *SeatManager) heapify(i int) {
    l := 2*i + 1
    r := 2*i + 2
    smallest := i
    if l < len(this.heap) && this.heap[l] < this.heap[smallest] {
        smallest = l
    }
    if r < len(this.heap) && this.heap[r] < this.heap[smallest] {
        smallest = r
    }
    if smallest != i {
        this.heap[i], this.heap[smallest] = this.heap[smallest], this.heap[i]
        this.heapify(smallest)
    }
}

func (this *SeatManager) bubbleUp(i int) {
    for i > 0 {
        parent := (i - 1) / 2
        if this.heap[parent] <= this.heap[i] {
            break
        }
        this.heap[parent], this.heap[i] = this.heap[i], this.heap[parent]
        i = parent
    }
}