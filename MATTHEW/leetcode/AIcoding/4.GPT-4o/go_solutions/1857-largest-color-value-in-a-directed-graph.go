func largestColorValue(colors string, edges [][]int) int {
    n := len(colors)
    graph := make([][]int, n)
    indegree := make([]int, n)

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        indegree[v]++
    }

    colorCount := make([][]int, n)
    for i := 0; i < n; i++ {
        colorCount[i] = make([]int, 26)
        colorCount[i][colors[i]-'a']++
    }

    queue := []int{}
    for i := 0; i < n; i++ {
        if indegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    maxColorValue := 0
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]

        for i := 0; i < 26; i++ {
            maxColorValue = max(maxColorValue, colorCount[node][i])
        }

        for _, neighbor := range graph[node] {
            for i := 0; i < 26; i++ {
                colorCount[neighbor][i] = max(colorCount[neighbor][i], colorCount[node][i])
            }
            indegree[neighbor]--
            if indegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    return maxColorValue
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}