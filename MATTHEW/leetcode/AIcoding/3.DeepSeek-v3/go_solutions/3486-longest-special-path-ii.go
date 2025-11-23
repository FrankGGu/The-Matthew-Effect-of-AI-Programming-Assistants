func longestPath(parent []int, s string) int {
    n := len(parent)
    children := make([][]int, n)
    for i := 1; i < n; i++ {
        p := parent[i]
        children[p] = append(children[p], i)
    }
    res := 1
    var dfs func(int) int
    dfs = func(node int) int {
        maxLen := 1
        for _, child := range children[node] {
            childLen := dfs(child)
            if s[node] != s[child] {
                if childLen+1 > maxLen {
                    maxLen = childLen + 1
                }
                if childLen+1 > res {
                    res = childLen + 1
                }
            }
        }
        return maxLen
    }
    dfs(0)
    return res
}