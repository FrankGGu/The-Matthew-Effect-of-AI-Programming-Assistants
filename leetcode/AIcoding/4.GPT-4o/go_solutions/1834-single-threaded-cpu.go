type Task struct {
    index int
    time  int
}

func getOrder(tasks [][]int) []int {
    n := len(tasks)
    tasksWithIndex := make([]Task, n)
    for i := 0; i < n; i++ {
        tasksWithIndex[i] = Task{i, tasks[i][0]}
    }

    sort.Slice(tasksWithIndex, func(i, j int) bool {
        return tasksWithIndex[i].time < tasksWithIndex[j].time
    })

    result := make([]int, 0, n)
    minHeap := &[]Task{}
    currentTime, i := 0, 0

    for len(result) < n {
        for i < n && tasksWithIndex[i].time <= currentTime {
            *minHeap = append(*minHeap, tasksWithIndex[i])
            i++
        }

        if len(*minHeap) == 0 {
            currentTime = tasksWithIndex[i].time
            continue
        }

        sort.Slice(*minHeap, func(a, b int) bool {
            if (*minHeap)[a].time == (*minHeap)[b].time {
                return (*minHeap)[a].index < (*minHeap)[b].index
            }
            return (*minHeap)[a].time < (*minHeap)[b].time
        })

        task := (*minHeap)[0]
        *minHeap = (*minHeap)[1:]

        result = append(result, task.index)
        currentTime += tasks[task.index][1]
    }

    return result
}