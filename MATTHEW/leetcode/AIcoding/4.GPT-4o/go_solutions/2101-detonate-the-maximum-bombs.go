func maximumDetonations(bombs [][]int) int {
    n := len(bombs)
    graph := make([][]int, n)

    for i := 0; i < n; i++ {
        x1, y1, r1 := bombs[i][0], bombs[i][1], bombs[i][2]
        for j := 0; j < n; j++ {
            if i != j {
                x2, y2 := bombs[j][0], bombs[j][1]
                if (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2) <= r1*r1 {
                    graph[i] = append(graph[i], j)
                }
            }
        }
    }

    var dfs func(int, []bool) int
    dfs = func(node int, visited []bool) int {
        visited[node] = true
        count := 1
        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                count += dfs(neighbor, visited)
            }
        }
        return count
    }

    maxDetonations := 0
    for i := 0; i < n; i++ {
        visited := make([]bool, n)
        maxDetonations = max(maxDetonations, dfs(i, visited))
    }

    return maxDetonations
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}