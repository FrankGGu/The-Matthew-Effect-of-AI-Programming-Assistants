import (
	"container/heap"
	"sort"
)

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

func scheduleCourse(courses [][]int) int {
	sort.Slice(courses, func(i, j int) bool {
		return courses[i][1] < courses[j][1]
	})

	maxHeap := &MaxHeap{}
	heap.Init(maxHeap)
	currentTime := 0

	for _, course := range courses {
		duration, end := course[0], course[1]
		if currentTime+duration <= end {
			heap.Push(maxHeap, duration)
			currentTime += duration
		} else if maxHeap.Len() > 0 && (*maxHeap)[0] > duration {
			currentTime += duration - heap.Pop(maxHeap).(int)
			heap.Push(maxHeap, duration)
		}
	}

	return maxHeap.Len()
}