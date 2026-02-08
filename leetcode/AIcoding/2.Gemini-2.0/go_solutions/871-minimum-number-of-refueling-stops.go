import "container/heap"

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] }
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

func minRefuelStops(target int, startFuel int, stations [][]int) int {
	h := &IntHeap{}
	heap.Init(h)
	stops := 0
	currFuel := startFuel
	i := 0
	for currFuel < target {
		for i < len(stations) && stations[i][0] <= currFuel {
			heap.Push(h, stations[i][1])
			i++
		}
		if h.Len() == 0 {
			return -1
		}
		currFuel += heap.Pop(h).(int)
		stops++
	}
	return stops
}