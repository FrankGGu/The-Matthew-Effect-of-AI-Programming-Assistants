package main

func minimumTime(n int, relations [][]int, courses []int) int {
    graph := make([][]int, n+1)
    inDegree := make([]int, n+1)
    for _, rel := range relations {
        u, v := rel[0], rel[1]
        graph[u] = append(graph[u], v)
        inDegree[v]++
    }

    time := make([]int, n+1)
    queue := []int{}
    for i := 1; i <= n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        for _, v := range graph[u] {
            time[v] = max(time[v], time[u]+courses[v-1])
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    maxTime := 0
    for i := 1; i <= n; i++ {
        maxTime = max(maxTime, time[i])
    }
    return maxTime
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}