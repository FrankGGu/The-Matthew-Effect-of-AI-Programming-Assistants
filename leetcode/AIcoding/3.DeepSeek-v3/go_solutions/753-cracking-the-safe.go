func crackSafe(n int, k int) string {
    if n == 1 {
        var sb strings.Builder
        for i := 0; i < k; i++ {
            sb.WriteByte(byte('0' + i))
        }
        return sb.String()
    }

    total := int(math.Pow(float64(k), float64(n)))
    visited := make(map[string]bool)
    var res strings.Builder

    start := strings.Repeat("0", n-1)
    var dfs func(string)
    dfs = func(node string) {
        for i := 0; i < k; i++ {
            next := node + string('0'+i)
            if !visited[next] {
                visited[next] = true
                dfs(next[1:])
                res.WriteByte(byte('0' + i))
            }
        }
    }

    dfs(start)
    res.WriteString(start)
    return res.String()
}