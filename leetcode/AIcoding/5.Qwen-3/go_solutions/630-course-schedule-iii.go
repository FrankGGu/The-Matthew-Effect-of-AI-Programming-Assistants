package main

func scheduleCourse(courses [][]int) int {
    sort.Slice(courses, func(i, j int) bool {
        return courses[i][1] < courses[j][1]
    })

    maxHeap := &MaxHeap{}
    for _, course := range courses {
        if *maxHeap + course[0] <= course[1] {
            heap.Push(maxHeap, course[0])
        } else {
            if len(*maxHeap) > 0 && (*maxHeap)[0] > course[0] {
                heap.Pop(maxHeap)
                heap.Push(maxHeap, course[0])
            }
        }
    }

    return len(*maxHeap)
}

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