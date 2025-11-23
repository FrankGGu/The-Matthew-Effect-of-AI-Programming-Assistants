func minReorder(n int, connections [][]int) int {
    graph := make([]map[int]bool, n)
    for i := range graph {
        graph[i] = make(map[int]bool)
    }

    outEdges := make([]bool, n)

    for _, conn := range connections {
        graph[conn[0]][conn[1]] = true
        graph[conn[1]][conn[0]] = false
        outEdges[conn[0]] = true
    }

    var dfs func(node int, visited []bool) int
    dfs = func(node int, visited []bool) int {
        visited[node] = true
        count := 0

        for neighbor, isOutward := range graph[node] {
            if !visited[neighbor] {
                if isOutward {
                    count++
                }
                count += dfs(neighbor, visited)
            }
        }

        return count
    }

    return dfs(0, make([]bool, n))
}