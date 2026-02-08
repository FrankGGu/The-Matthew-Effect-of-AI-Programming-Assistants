import "container/heap"

type RankItem struct {
    score int
    name string
}

type MaxHeap []RankItem

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool {
    if h[i].score != h[j].score {
        return h[i].score > h[j].score
    }
    return h[i].name < h[j].name
}
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(RankItem))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

type MinHeap []RankItem

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool {
    if h[i].score != h[j].score {
        return h[i].score < h[j].score
    }
    return h[i].name > h[j].name
}
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.(RankItem))
}

func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

type SORTracker struct {
    maxHeap MaxHeap
    minHeap MinHeap
    count int
}

func Constructor() SORTracker {
    return SORTracker{
        maxHeap: make(MaxHeap, 0),
        minHeap: make(MinHeap, 0),
        count: 0,
    }
}

func (this *SORTracker) Add(name string, score int)  {
    item := RankItem{score: score, name: name}
    heap.Push(&this.maxHeap, item)

    if this.count > 0 {
        top := heap.Pop(&this.maxHeap).(RankItem)
        heap.Push(&this.minHeap, top)
        if this.maxHeap.Len() > this.count {
            top = heap.Pop(&this.maxHeap).(RankItem)
            heap.Push(&this.minHeap, top)
        }
    }
    this.count++
}

func (this *SORTracker) Get() string {
    top := heap.Pop(&this.maxHeap).(RankItem)
    heap.Push(&this.minHeap, top)
    result := top.name

    if this.maxHeap.Len() < this.count -1{
        top = heap.Pop(&this.minHeap).(RankItem)
        heap.Push(&this.maxHeap, top)
    }

    return result
}