import (
	"container/heap"
	"sort"
)

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x any) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func scheduleCourse(courses [][]int) int {
	sort.Slice(courses, func(i, j int) bool {
		return courses[i][1] < courses[j][1]
	})

	pq := &MaxHeap{}
	heap.Init(pq)

	currentTime := 0

	for _, course := range courses {
		duration := course[0]
		lastDay := course[1]

		currentTime += duration
		heap.Push(pq, duration)

		if currentTime > lastDay {
			if pq.Len() > 0 {
				longestDuration := heap.Pop(pq).(int)
				currentTime -= longestDuration
			}
		}
	}

	return pq.Len()
}