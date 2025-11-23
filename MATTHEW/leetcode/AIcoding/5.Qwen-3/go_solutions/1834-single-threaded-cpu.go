package main

type Task struct {
    enqueueTime int
    processingTime int
}

func leastTimeToCompleteTasks(tasks [][]int) int {
    n := len(tasks)
    heap := make([]Task, n)
    for i := 0; i < n; i++ {
        heap[i] = Task{tasks[i][0], tasks[i][1]}
    }
    sort.Slice(heap, func(i, j int) bool {
        return heap[i].enqueueTime < heap[j].enqueueTime
    })

    var result int
    i := 0
    h := &TaskHeap{}
    for i < n || h.Len() > 0 {
        if h.Len() == 0 {
            result = heap[i].enqueueTime
        }
        for i < n && heap[i].enqueueTime <= result {
            heap.Push(h, heap[i])
            i++
        }
        if h.Len() == 0 {
            result = heap[i].enqueueTime
        } else {
            task := heap.Pop(h).(Task)
            result += task.processingTime
        }
    }
    return result
}

type TaskHeap []Task

func (h TaskHeap) Len() int           { return len(h) }
func (h TaskHeap) Less(i, j int) bool { return h[i].processingTime < h[j].processingTime || (h[i].processingTime == h[j].processingTime && h[i].enqueueTime < h[j].enqueueTime) }
func (h TaskHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *TaskHeap) Push(x interface{}) {
    *h = append(*h, x.(Task))
}

func (h *TaskHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}