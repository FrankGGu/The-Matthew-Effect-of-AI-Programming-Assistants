package main

func crackSafe(n int, k int) string {
    visited := make(map[string]bool)
    total := 1
    for i := 0; i < k; i++ {
        total *= k
    }
    result := make([]byte, n)
    for i := 0; i < n; i++ {
        result[i] = '0'
    }
    if dfs(n, k, visited, total, result) {
        return string(result)
    }
    return ""
}

func dfs(n, k int, visited map[string]bool, total int, result []byte) bool {
    if len(visited) == total {
        return true
    }
    for i := 0; i < k; i++ {
        current := string(result[len(result)-n+1:])
        next := current + string('0'+i)
        if !visited[next] {
            visited[next] = true
            result = append(result, byte('0'+i))
            if dfs(n, k, visited, total, result) {
                return true
            }
            result = result[:len(result)-1]
            visited[next] = false
        }
    }
    return false
}