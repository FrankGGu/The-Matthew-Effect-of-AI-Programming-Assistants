package main

func minTimeToEmpty(n int, relations [][]int) int {
    graph := make([][]int, n)
    inDegree := make([]int, n)
    for _, r := range relations {
        u, v := r[0], r[1]
        graph[u] = append(graph[u], v)
        inDegree[v]++
    }

    queue := []int{}
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    time := make([]int, n)
    maxTime := 0

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]

        for _, neighbor := range graph[node] {
            inDegree[neighbor]--
            time[neighbor] = max(time[neighbor], time[node]+1)
            if inDegree[neighbor] == 0 {
                queue = append(queue, neighbor)
                maxTime = max(maxTime, time[neighbor])
            }
        }
    }

    return maxTime
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}