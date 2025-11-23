import (
    "container/heap"
)

type Course struct {
    pass, total int
}

type MaxHeap []Course

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return float64(h[i].pass)/float64(h[i].total+1) > float64(h[j].pass)/float64(h[j].total) }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(Course))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func maxAverageRatio(classes [][]int, extraStudents int) float64 {
    h := &MaxHeap{}
    heap.Init(h)

    for _, class := range classes {
        heap.Push(h, Course{class[0], class[1]})
    }

    for i := 0; i < extraStudents; i++ {
        course := heap.Pop(h).(Course)
        course.pass++
        course.total++
        heap.Push(h, course)
    }

    totalPass := 0
    totalClasses := 0

    for h.Len() > 0 {
        course := heap.Pop(h).(Course)
        totalPass += course.pass
        totalClasses += course.total
    }

    return float64(totalPass) / float64(totalClasses)
}