import (
	"container/heap"
	"sort"
)

type meeting struct {
	start int
	end   int
}

type interval struct {
	start int
	end   int
}

type priorityQueue []int

func (pq priorityQueue) Len() int {
	return len(pq)
}

func (pq priorityQueue) Less(i, j int) bool {
	return pq[i] < pq[j]
}

func (pq priorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *priorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(int))
}

func (pq *priorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	x := old[n-1]
	*pq = old[0 : n-1]
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func maxFreeTime(meetings [][]meeting) int {
	allMeetings := []interval{}
	for _, personMeetings := range meetings {
		for _, m := range personMeetings {
			allMeetings = append(allMeetings, interval{start: m.start, end: m.end})
		}
	}

	sort.Slice(allMeetings, func(i, j int) bool {
		return allMeetings[i].start < allMeetings[j].start
	})

	pq := &priorityQueue{}
	heap.Init(pq)
	heap.Push(pq, allMeetings[0].end)

	maxFree := 0
	prevEnd := allMeetings[0].start

	for i := 1; i < len(allMeetings); i++ {
		top := heap.Pop(pq).(int)
		maxFree = max(maxFree, allMeetings[i].start - top)

		prevEnd = max(prevEnd, allMeetings[i].start)

		heap.Push(pq, max(top, allMeetings[i].end))
	}

	return maxFree
}