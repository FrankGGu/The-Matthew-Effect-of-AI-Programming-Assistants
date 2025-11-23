func maxEnjoyment(n int, paths [][]int, enjoyment []int) int {
    graph := make([][]int, n)
    for _, p := range paths {
        graph[p[0]] = append(graph[p[0]], p[1])
        graph[p[1]] = append(graph[p[1]], p[0])
    }

    visited := make([]bool, n)
    var dfs func(node int) int
    dfs = func(node int) int {
        visited[node] = true
        maxEnjoy := enjoyment[node]
        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                maxEnjoy = max(maxEnjoy, enjoyment[node]+dfs(neighbor))
            }
        }
        return maxEnjoy
    }

    maxTotalEnjoyment := 0
    for i := 0; i < n; i++ {
        if !visited[i] {
            maxTotalEnjoyment = max(maxTotalEnjoyment, dfs(i))
        }
    }
    return maxTotalEnjoyment
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}