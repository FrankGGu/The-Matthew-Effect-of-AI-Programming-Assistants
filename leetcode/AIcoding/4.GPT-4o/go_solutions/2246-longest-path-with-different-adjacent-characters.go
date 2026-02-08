func longestPath(parent []int, s string) int {
    n := len(parent)
    graph := make([][]int, n)
    for i := 1; i < n; i++ {
        graph[parent[i]]. = append(graph[parent[i]], i)
    }

    var dfs func(int) int
    dfs = func(node int) int {
        max1, max2 := 0, 0
        for _, child := range graph[node] {
            length := dfs(child)
            if s[child] != s[node] {
                if length > max1 {
                    max2 = max1
                    max1 = length
                } else if length > max2 {
                    max2 = length
                }
            }
        }
        ans := max1 + max2 + 1
        maxPath = max(maxPath, ans)
        return max1 + 1
    }

    maxPath := 0
    dfs(0)
    return maxPath
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}