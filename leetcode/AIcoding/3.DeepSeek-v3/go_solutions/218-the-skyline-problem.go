import (
	"container/heap"
	"sort"
)

type Event struct {
    x int
    height int
    isStart bool
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

func getSkyline(buildings [][]int) [][]int {
    events := make([]Event, 0, 2*len(buildings))
    for _, b := range buildings {
        events = append(events, Event{b[0], b[2], true})
        events = append(events, Event{b[1], b[2], false})
    }

    sort.Slice(events, func(i, j int) bool {
        if events[i].x != events[j].x {
            return events[i].x < events[j].x
        }
        if events[i].isStart && events[j].isStart {
            return events[i].height > events[j].height
        }
        if !events[i].isStart && !events[j].isStart {
            return events[i].height < events[j].height
        }
        return events[i].isStart
    })

    maxHeap := &MaxHeap{}
    heap.Init(maxHeap)
    heap.Push(maxHeap, 0)
    prevMax := 0
    result := [][]int{}

    for _, e := range events {
        if e.isStart {
            heap.Push(maxHeap, e.height)
        } else {
            for i := 0; i < len(*maxHeap); i++ {
                if (*maxHeap)[i] == e.height {
                    heap.Remove(maxHeap, i)
                    break
                }
            }
        }

        currentMax := (*maxHeap)[0]
        if currentMax != prevMax {
            result = append(result, []int{e.x, currentMax})
            prevMax = currentMax
        }
    }

    return result
}