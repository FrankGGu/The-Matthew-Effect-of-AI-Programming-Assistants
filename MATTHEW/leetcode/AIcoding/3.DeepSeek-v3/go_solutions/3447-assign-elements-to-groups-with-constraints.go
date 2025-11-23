func assignGroups(n int, constraints [][]int) []int {
    graph := make(map[int][]int)
    inDegree := make(map[int]int)

    for i := 0; i < n; i++ {
        inDegree[i] = 0
    }

    for _, c := range constraints {
        u, v := c[0], c[1]
        graph[u] = append(graph[u], v)
        inDegree[v]++
    }

    queue := make([]int, 0)
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    group := make([]int, n)
    currentGroup := 1

    for len(queue) > 0 {
        nextQueue := make([]int, 0)
        for _, u := range queue {
            group[u] = currentGroup
            for _, v := range graph[u] {
                inDegree[v]--
                if inDegree[v] == 0 {
                    nextQueue = append(nextQueue, v)
                }
            }
        }
        queue = nextQueue
        currentGroup++
    }

    for i := 0; i < n; i++ {
        if group[i] == 0 {
            return []int{}
        }
    }

    return group
}