func findCircleNum(isConnected [][]int) int {
    n := len(isConnected)
    visited := make([]bool, n)
    count := 0

    var dfs func(int)
    dfs = func(node int) {
        for i := 0; i < n; i++ {
            if isConnected[node][i] == 1 && !visited[i] {
                visited[i] = true
                dfs(i)
            }
        }
    }

    for i := 0; i < n; i++ {
        if !visited[i] {
            dfs(i)
            count++
        }
    }

    return count
}