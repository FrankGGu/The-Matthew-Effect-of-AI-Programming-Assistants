package main

type Pair struct {
    dist, fuel int
}

func minRefuelStops(target int, startFuel int, stations [][]int) int {
    if startFuel >= target {
        return 0
    }

    var maxHeap []int
    stations = append(stations, []int{target, 0})

    prev := 0
    count := 0

    for _, station := range stations {
        dist := station[0]
        fuel := station[1]

        startFuel -= dist - prev

        for startFuel < 0 && len(maxHeap) > 0 {
            startFuel += -heap.Pop(&maxHeap).(int)
            count++
        }

        if startFuel < 0 {
            return -1
        }

        heap.Push(&maxHeap, -fuel)
        prev = dist
    }

    return count
}

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}