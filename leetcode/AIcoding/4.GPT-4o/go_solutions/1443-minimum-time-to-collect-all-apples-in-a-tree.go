func minTime(n int, edges [][]int, hasApple []bool) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    var dfs func(node, parent int) int
    dfs = func(node, parent int) int {
        time := 0
        for _, neighbor := range graph[node] {
            if neighbor != parent {
                timeFromChild := dfs(neighbor, node)
                if timeFromChild > 0 || hasApple[neighbor] {
                    time += timeFromChild + 2
                }
            }
        }
        return time
    }

    return dfs(0, -1)
}