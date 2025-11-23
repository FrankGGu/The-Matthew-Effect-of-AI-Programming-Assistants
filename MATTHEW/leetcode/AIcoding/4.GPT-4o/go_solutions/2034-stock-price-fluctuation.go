type StockPrice struct {
    timestamps map[int]int
    maxHeap    *MaxHeap
    minHeap    *MinHeap
}

func Constructor() StockPrice {
    return StockPrice{
        timestamps: make(map[int]int),
        maxHeap:    NewMaxHeap(),
        minHeap:    NewMinHeap(),
    }
}

func (this *StockPrice) Update(timestamp int, price int) {
    if oldPrice, exists := this.timestamps[timestamp]; exists {
        this.maxHeap.Remove(oldPrice)
        this.minHeap.Remove(oldPrice)
    }
    this.timestamps[timestamp] = price
    this.maxHeap.Add(price)
    this.minHeap.Add(price)
}

func (this *StockPrice) Current() int {
    return this.timestamps[this.maxHeap.Peek()]
}

func (this *StockPrice) Maximum() int {
    return this.maxHeap.Peek()
}

func (this *StockPrice) Minimum() int {
    return this.minHeap.Peek()
}

type MaxHeap struct {
    data []int
}

func NewMaxHeap() *MaxHeap {
    return &MaxHeap{data: []int{}}
}

func (h *MaxHeap) Add(val int) {
    h.data = append(h.data, val)
    h.heapifyUp(len(h.data) - 1)
}

func (h *MaxHeap) Remove(val int) {
    for i, v := range h.data {
        if v == val {
            h.data = append(h.data[:i], h.data[i+1:]...)
            h.heapifyDown(i)
            break
        }
    }
}

func (h *MaxHeap) Peek() int {
    return h.data[0]
}

func (h *MaxHeap) heapifyUp(index int) {
    for index > 0 {
        parent := (index - 1) / 2
        if h.data[index] <= h.data[parent] {
            break
        }
        h.data[index], h.data[parent] = h.data[parent], h.data[index]
        index = parent
    }
}

func (h *MaxHeap) heapifyDown(index int) {
    lastIndex := len(h.data) - 1
    largest := index
    for {
        left := 2*index + 1
        right := 2*index + 2
        if left <= lastIndex && h.data[left] > h.data[largest] {
            largest = left
        }
        if right <= lastIndex && h.data[right] > h.data[largest] {
            largest = right
        }
        if largest == index {
            break
        }
        h.data[index], h.data[largest] = h.data[largest], h.data[index]
        index = largest
    }
}

type MinHeap struct {
    data []int
}

func NewMinHeap() *MinHeap {
    return &MinHeap{data: []int{}}
}

func (h *MinHeap) Add(val int) {
    h.data = append(h.data, val)
    h.heapifyUp(len(h.data) - 1)
}

func (h *MinHeap) Remove(val int) {
    for i, v := range h.data {
        if v == val {
            h.data = append(h.data[:i], h.data[i+1:]...)
            h.heapifyDown(i)
            break
        }
    }
}

func (h *MinHeap) Peek() int {
    return h.data[0]
}

func (h *MinHeap) heapifyUp(index int) {
    for index > 0 {
        parent := (index - 1) / 2
        if h.data[index] >= h.data[parent] {
            break
        }
        h.data[index], h.data[parent] = h.data[parent], h.data[index]
        index = parent
    }
}

func (h *MinHeap) heapifyDown(index int) {
    lastIndex := len(h.data) - 1
    smallest := index
    for {
        left := 2*index + 1
        right := 2*index + 2
        if left <= lastIndex && h.data[left] < h.data[smallest] {
            smallest = left
        }
        if right <= lastIndex && h.data[right] < h.data[smallest] {
            smallest = right
        }
        if smallest == index {
            break
        }
        h.data[index], h.data[smallest] = h.data[smallest], h.data[index]
        index = smallest
    }
}