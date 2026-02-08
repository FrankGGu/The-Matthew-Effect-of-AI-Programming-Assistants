func crackSafe(n int, k int) string {
    result := []byte{}
    visited := make(map[string]bool)

    var dfs func(cur string, length int)
    dfs = func(cur string, length int) {
        if length == 0 {
            return
        }
        for i := 0; i < k; i++ {
            next := cur + string('0'+i)
            if !visited[next] {
                visited[next] = true
                dfs(next[1:], length-1)
                result = append(result, '0'+byte(i))
            }
        }
    }

    initial := strings.Repeat("0", n-1)
    dfs(initial, int(math.Pow(float64(k), float64(n))) - 1)
    result = append(result, initial...)

    return string(result)
}