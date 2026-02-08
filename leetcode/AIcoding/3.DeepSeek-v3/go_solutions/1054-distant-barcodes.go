func rearrangeBarcodes(barcodes []int) []int {
    freq := make(map[int]int)
    for _, b := range barcodes {
        freq[b]++
    }

    maxHeap := &MaxHeap{}
    heap.Init(maxHeap)
    for num, count := range freq {
        heap.Push(maxHeap, &Item{num: num, count: count})
    }

    res := make([]int, len(barcodes))
    i := 0
    for maxHeap.Len() > 0 {
        item := heap.Pop(maxHeap).(*Item)
        if i == 0 || res[i-1] != item.num {
            res[i] = item.num
            item.count--
            i++
        } else {
            if maxHeap.Len() == 0 {
                return nil
            }
            nextItem := heap.Pop(maxHeap).(*Item)
            res[i] = nextItem.num
            nextItem.count--
            i++
            if nextItem.count > 0 {
                heap.Push(maxHeap, nextItem)
            }
        }
        if item.count > 0 {
            heap.Push(maxHeap, item)
        }
    }
    return res
}

type Item struct {
    num   int
    count int
}

type MaxHeap []*Item

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].count > h[j].count }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(*Item))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    item := old[n-1]
    *h = old[0 : n-1]
    return item
}