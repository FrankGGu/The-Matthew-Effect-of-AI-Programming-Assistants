func countCoveredBuildings(buildings [][]int) int {
    events := []struct {
        x    int
        h    int
        type_ int
    }{}

    for _, b := range buildings {
        events = append(events, struct {
            x    int
            h    int
            type_ int
        }{b[0], b[2], 1})
        events = append(events, struct {
            x    int
            h    int
            type_ int
        }{b[1], b[2], -1})
    }

    sort.Slice(events, func(i, j int) bool {
        if events[i].x == events[j].x {
            return events[i].type_ > events[j].type_
        }
        return events[i].x < events[j].x
    })

    maxHeap := &MaxHeap{}
    heap.Init(maxHeap)
    lastX := events[0].x
    covered := 0

    for _, event := range events {
        if maxHeap.Len() > 0 {
            height := (*maxHeap)[0]
            covered += max(0, event.x-lastX) * height
        }
        if event.type_ == 1 {
            heap.Push(maxHeap, event.h)
        } else {
            for i := 0; i < maxHeap.Len(); i++ {
                if (*maxHeap)[i] == event.h {
                    heap.Remove(maxHeap, i)
                    break
                }
            }
        }
        lastX = event.x
    }

    return covered
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}