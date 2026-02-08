type NumberContainers struct {
    indexToNumber map[int]int
    numberToIndices map[int]*IntHeap
}

func Constructor() NumberContainers {
    return NumberContainers{
        indexToNumber: make(map[int]int),
        numberToIndices: make(map[int]*IntHeap),
    }
}

func (this *NumberContainers) Change(index int, number int)  {
    if prevNum, exists := this.indexToNumber[index]; exists {
        heap.Remove(this.numberToIndices[prevNum], this.numberToIndices[prevNum].indexMap[index])
        delete(this.numberToIndices[prevNum].indexMap, index)
    }
    this.indexToNumber[index] = number
    if _, exists := this.numberToIndices[number]; !exists {
        this.numberToIndices[number] = &IntHeap{[]int{}, make(map[int]int)}
    }
    heap.Push(this.numberToIndices[number], index)
    this.numberToIndices[number].indexMap[index] = len(this.numberToIndices[number].heap) - 1
}

func (this *NumberContainers) Find(number int) int {
    if h, exists := this.numberToIndices[number]; exists && len(h.heap) > 0 {
        return h.heap[0]
    }
    return -1
}

type IntHeap struct {
    heap []int
    indexMap map[int]int
}

func (h IntHeap) Len() int           { return len(h.heap) }
func (h IntHeap) Less(i, j int) bool { return h.heap[i] < h.heap[j] }
func (h IntHeap) Swap(i, j int)      { 
    h.heap[i], h.heap[j] = h.heap[j], h.heap[i] 
    h.indexMap[h.heap[i]] = i
    h.indexMap[h.heap[j]] = j
}
func (h *IntHeap) Push(x interface{}) { 
    h.heap = append(h.heap, x.(int))
}
func (h *IntHeap) Pop() interface{} {
    old := h.heap
    n := len(old)
    x := old[n-1]
    h.heap = old[0 : n-1]
    delete(h.indexMap, x)
    return x
}