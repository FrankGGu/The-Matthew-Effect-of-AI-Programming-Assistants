import (
    "container/heap"
    "sort"
)

type Task struct {
    index int
    enqueueTime int
    processingTime int
}

type MinHeap []Task

func (h MinHeap) Len() int { return len(h) }
func (h MinHeap) Less(i, j int) bool {
    if h[i].processingTime == h[j].processingTime {
        return h[i].index < h[j].index
    }
    return h[i].processingTime < h[j].processingTime
}
func (h MinHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) { *h = append(*h, x.(Task)) }
func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}

func getOrder(tasks [][]int) []int {
    n := len(tasks)
    taskList := make([]Task, n)
    for i := 0; i < n; i++ {
        taskList[i] = Task{i, tasks[i][0], tasks[i][1]}
    }
    sort.Slice(taskList, func(i, j int) bool {
        return taskList[i].enqueueTime < taskList[j].enqueueTime
    })

    res := make([]int, 0, n)
    h := &MinHeap{}
    heap.Init(h)
    currentTime := 0
    i := 0

    for len(res) < n {
        for i < n && taskList[i].enqueueTime <= currentTime {
            heap.Push(h, taskList[i])
            i++
        }
        if h.Len() == 0 {
            if i < n {
                currentTime = taskList[i].enqueueTime
            }
            continue
        }
        task := heap.Pop(h).(Task)
        res = append(res, task.index)
        currentTime += task.processingTime
    }
    return res
}