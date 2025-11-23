package main

type StockPrice struct {
    priceMap map[int]int
    maxHeap  [][2]int
    minHeap  [][2]int
    latestTime int
}

func Constructor() StockPrice {
    return StockPrice{
        priceMap: make(map[int]int),
        maxHeap:  [][2]int{},
        minHeap:  [][2]int{},
    }
}

func (s *StockPrice) Update(timestamp int, price int) {
    s.priceMap[timestamp] = price
    if timestamp > s.latestTime {
        s.latestTime = timestamp
    }
    heap.Push(&s.maxHeap, [2]int{-timestamp, price})
    heap.Push(&s.minHeap, [2]int{timestamp, price})
}

func (s *StockPrice) Current() int {
    return s.priceMap[s.latestTime]
}

func (s *StockPrice) Maximum() int {
    for len(s.maxHeap) > 0 {
        time, price := s.maxHeap[0][0], s.maxHeap[0][1]
        if s.priceMap[-time] == price {
            return price
        }
        heap.Pop(&s.maxHeap)
    }
    return -1
}

func (s *StockPrice) Minimum() int {
    for len(s.minHeap) > 0 {
        time, price := s.minHeap[0][0], s.minHeap[0][1]
        if s.priceMap[time] == price {
            return price
        }
        heap.Pop(&s.minHeap)
    }
    return -1
}

type maxHeap [][2]int

func (h maxHeap) Len() int           { return len(h) }
func (h maxHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h maxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *maxHeap) Push(x interface{}) {
    *h = append(*h, x.([2]int))
}
func (h *maxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

type minHeap [][2]int

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *minHeap) Push(x interface{}) {
    *h = append(*h, x.([2]int))
}
func (h *minHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}