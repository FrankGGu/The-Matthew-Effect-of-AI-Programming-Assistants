type NumberContainer struct {
    indexMap map[int]int
    valueMap map[int]map[int]struct{}
    minHeap  *minHeap
}

func Constructor() NumberContainer {
    return NumberContainer{
        indexMap: make(map[int]int),
        valueMap: make(map[int]map[int]struct{}),
        minHeap:  &minHeap{},
    }
}

func (this *NumberContainer) Change(number int, weight int) {
    if _, exists := this.indexMap[number]; exists {
        oldWeight := this.indexMap[number]
        delete(this.valueMap[oldWeight], number)
        if len(this.valueMap[oldWeight]) == 0 {
            delete(this.valueMap, oldWeight)
        }
    }
    this.indexMap[number] = weight
    if this.valueMap[weight] == nil {
        this.valueMap[weight] = make(map[int]struct{})
    }
    this.valueMap[weight][number] = struct{}{}
    this.minHeap.Push(weight)
}

func (this *NumberContainer) Find(number int) int {
    if weight, exists := this.indexMap[number]; exists {
        return weight
    }
    return -1
}

func (this *NumberContainer) Minimum() int {
    for this.minHeap.Len() > 0 {
        weight := this.minHeap.Peek()
        if _, exists := this.valueMap[weight]; exists {
            return weight
        }
        this.minHeap.Pop()
    }
    return -1
}

type minHeap []int

func (h *minHeap) Len() int {
    return len(*h)
}

func (h *minHeap) Less(i, j int) bool {
    return (*h)[i] < (*h)[j]
}

func (h *minHeap) Swap(i, j int) {
    (*h)[i], (*h)[j] = (*h)[j], (*h)[i]
}

func (h *minHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *minHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func (h *minHeap) Peek() int {
    return (*h)[0]
}