import "container/heap"

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

func maxEvents(events [][]int) int {
	sort.Slice(events, func(i, j int) bool {
		return events[i][0] < events[j][0]
	})

	h := &IntHeap{}
	heap.Init(h)

	eventIndex := 0
	attendedEvents := 0
	day := 1

	for eventIndex < len(events) || h.Len() > 0 {
		for eventIndex < len(events) && events[eventIndex][0] <= day {
			heap.Push(h, events[eventIndex][1])
			eventIndex++
		}

		for h.Len() > 0 && (*h)[0] < day {
			heap.Pop(h)
		}

		if h.Len() > 0 {
			heap.Pop(h)
			attendedEvents++
		}

		day++
	}

	return attendedEvents
}