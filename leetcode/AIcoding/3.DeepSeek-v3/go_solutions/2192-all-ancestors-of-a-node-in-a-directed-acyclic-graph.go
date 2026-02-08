func getAncestors(n int, edges [][]int) [][]int {
    graph := make([][]int, n)
    inDegree := make([]int, n)
    ancestors := make([]map[int]bool, n)

    for i := 0; i < n; i++ {
        ancestors[i] = make(map[int]bool)
    }

    for _, edge := range edges {
        from, to := edge[0], edge[1]
        graph[from] = append(graph[from], to)
        inDegree[to]++
    }

    queue := []int{}
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]

        for _, v := range graph[u] {
            for ancestor := range ancestors[u] {
                ancestors[v][ancestor] = true
            }
            ancestors[v][u] = true
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    result := make([][]int, n)
    for i := 0; i < n; i++ {
        for ancestor := range ancestors[i] {
            result[i] = append(result[i], ancestor)
        }
        sort.Ints(result[i])
    }

    return result
}