import (
	"container/heap"
	"sort"
)

func mostBooked(n int, meetings [][]int) int {
    sort.Slice(meetings, func(i, j int) bool {
        return meetings[i][0] < meetings[j][0]
    })

    available := make([]int, n)
    for i := range available {
        available[i] = i
    }
    used := &MinHeap{}
    heap.Init(used)

    count := make([]int, n)

    for _, meeting := range meetings {
        start, end := meeting[0], meeting[1]

        for used.Len() > 0 && (*used)[0].endTime <= start {
            room := heap.Pop(used).(Room)
            heap.Push(&available, room.roomID)
        }

        if len(available) > 0 {
            roomID := heap.Pop(&available).(int)
            count[roomID]++
            heap.Push(used, Room{endTime: end, roomID: roomID})
        } else {
            earliest := heap.Pop(used).(Room)
            duration := end - start
            count[earliest.roomID]++
            heap.Push(used, Room{endTime: earliest.endTime + duration, roomID: earliest.roomID})
        }
    }

    maxCount := 0
    result := 0
    for i := 0; i < n; i++ {
        if count[i] > maxCount {
            maxCount = count[i]
            result = i
        }
    }
    return result
}

type Room struct {
    endTime int
    roomID  int
}

type MinHeap []Room

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { 
    if h[i].endTime == h[j].endTime {
        return h[i].roomID < h[j].roomID
    }
    return h[i].endTime < h[j].endTime 
}
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.(Room))
}

func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}