func longestSpecialPath(parent []int, s string) int {
    n := len(parent)
    graph := make([][]int, n)
    for i := 1; i < n; i++ {
        p := parent[i]
        graph[p] = append(graph[p], i)
    }
    maxLen := 1
    var dfs func(int) int
    dfs = func(u int) int {
        max1, max2 := 0, 0
        for _, v := range graph[u] {
            l := dfs(v)
            if s[u] != s[v] {
                if l > max1 {
                    max2 = max1
                    max1 = l
                } else if l > max2 {
                    max2 = l
                }
            }
        }
        maxLen = max(maxLen, max1+max2+1)
        return max1 + 1
    }
    dfs(0)
    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}