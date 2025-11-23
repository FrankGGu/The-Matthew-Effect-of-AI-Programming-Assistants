func findCircleNum(isConnected [][]int) int {
    n := len(isConnected)
    if n == 0 {
        return 0
    }

    visited := make([]bool, n)
    provinces := 0

    var dfs func(city int)
    dfs = func(city int) {
        visited[city