func numOfMinutes(n int, headID int, manager []int, informTime []int) int {
    graph := make(map[int][]int)
    for i := 0; i < n; i++ {
        if manager[i] != -1 {
            graph[manager[i]] = append(graph[manager[i]], i)
        }
    }

    queue := [][]int{{headID, 0}}
    maxTime := 0

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        currentID, currentTime := node[0], node[1]

        if currentTime > maxTime {
            maxTime = currentTime
        }

        for _, subordinate := range graph[currentID] {
            queue = append(queue, []int{subordinate, currentTime + informTime[currentID]})
        }
    }

    return maxTime
}