func findCircleNum(isConnected [][]int) int {
    n := len(isConnected)
    visited := make([]bool, n)
    provinces := 0

    var dfs func(int)
    dfs = func(i int) {
        visited[i] = true
        for j := 0; j < n; j++ {
            if isConnected[i][j] == 1 && !visited[j] {
                dfs(j)
            }
        }
    }

    for i := 0; i < n; i++ {
        if !visited[i] {
            dfs(i)
            provinces++
        }
    }

    return provinces
}