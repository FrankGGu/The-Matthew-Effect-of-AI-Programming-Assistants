func longestPath(parent []int, s string) int {
    n := len(parent)
    children := make([][]int, n)
    for i := 1; i < n; i++ {
        children[parent[i]] = append(children[parent[i]], i)
    }

    ans := 1
    var dfs func(node int) int
    dfs = func(node int) int {
        maxLen1, maxLen2 := 0, 0
        for _, child := range children[node] {
            len := dfs(child)
            if s[node] != s[child] {
                if len > maxLen1 {
                    maxLen2 = maxLen1
                    maxLen1 = len
                } else if len > maxLen2 {
                    maxLen2 = len
                }
            }
        }
        ans = max(ans, maxLen1+maxLen2+1)
        return maxLen1 + 1
    }

    dfs(0)
    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}