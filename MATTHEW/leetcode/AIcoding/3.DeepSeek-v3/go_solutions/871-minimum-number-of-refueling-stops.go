import (
	"container/heap"
)

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
	maxHeap := &IntHeap{}
	heap.Init(maxHeap)
	res := 0
	prev := 0
	tank := startFuel

	for i := 0; i < len(stations); i++ {
		location := stations[i][0]
		capacity := stations[i][1]
		tank -= location - prev
		for maxHeap.Len() > 0 && tank < 0 {
			tank += heap.Pop(maxHeap).(int)
			res++
		}
		if tank < 0 {
			return -1
		}
		heap.Push(maxHeap, capacity)
		prev = location
	}

	tank -= target - prev
	for maxHeap.Len() > 0 && tank < 0 {
		tank += heap.Pop(maxHeap).(int)
		res++
	}
	if tank < 0 {
		return -1
	}
	return res
}