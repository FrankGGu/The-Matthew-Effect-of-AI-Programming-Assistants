func minimumTime(n int, relations [][]int, time []int) int {
    inDegree := make([]int, n+1)
    graph := make([][]int, n+1)
    for _, rel := range relations {
        prev, next := rel[0], rel[1]
        graph[prev] = append(graph[prev], next)
        inDegree[next]++
    }

    queue := make([]int, 0)
    maxTime := make([]int, n+1)
    for i := 1; i <= n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
            maxTime[i] = time[i-1]
        }
    }

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        for _, v := range graph[u] {
            if maxTime[v] < maxTime[u] + time[v-1] {
                maxTime[v] = maxTime[u] + time[v-1]
            }
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    res := 0
    for i := 1; i <= n; i++ {
        if maxTime[i] > res {
            res = maxTime[i]
        }
    }
    return res
}