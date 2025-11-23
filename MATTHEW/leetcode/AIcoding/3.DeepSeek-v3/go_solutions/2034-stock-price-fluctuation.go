type StockPrice struct {
    prices map[int]int
    maxTimestamp int
    maxHeap *MaxHeap
    minHeap *MinHeap
}

type MaxHeap []int
type MinHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MaxHeap) Push(x interface{}) { *h = append(*h, x.(int)) }
func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) { *h = append(*h, x.(int)) }
func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func Constructor() StockPrice {
    return StockPrice{
        prices: make(map[int]int),
        maxTimestamp: 0,
        maxHeap: &MaxHeap{},
        minHeap: &MinHeap{},
    }
}

func (this *StockPrice) Update(timestamp int, price int) {
    this.prices[timestamp] = price
    if timestamp > this.maxTimestamp {
        this.maxTimestamp = timestamp
    }
    heap.Push(this.maxHeap, price)
    heap.Push(this.minHeap, price)
}

func (this *StockPrice) Current() int {
    return this.prices[this.maxTimestamp]
}

func (this *StockPrice) Maximum() int {
    for {
        max := (*this.maxHeap)[0]
        if this.prices[this.maxTimestamp] == max {
            break
        }
        heap.Pop(this.maxHeap)
    }
    return (*this.maxHeap)[0]
}

func (this *StockPrice) Minimum() int {
    for {
        min := (*this.minHeap)[0]
        if this.prices[this.maxTimestamp] == min {
            break
        }
        heap.Pop(this.minHeap)
    }
    return (*this.minHeap)[0]
}