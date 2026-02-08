func longestPath(parent []int, s string) int {
    n := len(parent)
    children := make([][]int, n)
    for i := 1; i < n; i++ {
        p := parent[i]
        children[p] = append(children[p], i)
    }

    maxLen := 1
    var dfs func(int) int
    dfs = func(node int) int {
        max1, max2 := 0, 0
        for _, child := range children[node] {
            childLen := dfs(child)
            if s[child] != s[node] {
                if childLen > max1 {
                    max2 = max1
                    max1 = childLen
                } else if childLen > max2 {
                    max2 = childLen
                }
            }
        }
        currentMax := max1 + max2 + 1
        if currentMax > maxLen {
            maxLen = currentMax
        }
        return max1 + 1
    }
    dfs(0)
    return maxLen
}