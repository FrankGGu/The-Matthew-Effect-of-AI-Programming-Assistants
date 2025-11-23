import (
	"container/heap"
	"sort"
)

type Event struct {
    time int
    typ  int // 0: leave, 1: arrive
    idx  int
}

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) { *h = append(*h, x.(int)) }
func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}

func smallestChair(times [][]int, targetFriend int) int {
    n := len(times)
    events := make([]Event, 0, 2*n)
    for i := 0; i < n; i++ {
        arrive, leave := times[i][0], times[i][1]
        events = append(events, Event{arrive, 1, i})
        events = append(events, Event{leave, 0, i})
    }
    sort.Slice(events, func(i, j int) bool {
        if events[i].time == events[j].time {
            return events[i].typ < events[j].typ
        }
        return events[i].time < events[j].time
    })

    available := &MinHeap{}
    heap.Init(available)
    for i := 0; i < n; i++ {
        heap.Push(available, i)
    }

    seat := make(map[int]int)

    for _, event := range events {
        if event.typ == 1 {
            s := heap.Pop(available).(int)
            seat[event.idx] = s
            if event.idx == targetFriend {
                return s
            }
        } else {
            s := seat[event.idx]
            heap.Push(available, s)
        }
    }
    return -1
}