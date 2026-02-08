func maxEmployees(invitees [][]int) int {
    n := len(invitees)
    graph := make([][]int, n)
    for i := 0; i < n; i++ {
        for _, j := range invitees[i] {
            graph[i] = append(graph[i], j)
        }
    }

    var dfs func(int, []bool) int
    dfs = func(node int, visited []bool) int {
        if visited[node] {
            return 0
        }
        visited[node] = true
        count := 1
        for _, neighbor := range graph[node] {
            count += dfs(neighbor, visited)
        }
        return count
    }

    maxCount := 0
    for i := 0; i < n; i++ {
        visited := make([]bool, n)
        count := dfs(i, visited)
        if count > maxCount {
            maxCount = count
        }
    }
    return maxCount
}