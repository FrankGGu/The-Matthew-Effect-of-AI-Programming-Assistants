func canReach(arr []int, start int) bool {
    n := len(arr)
    visited := make([]bool, n)

    var dfs func(index int) bool
    dfs = func(index int) bool {
        if index < 0 || index >= n || visited[index] {
            return false
        }
        if arr[index] == 0 {
            return true
        }
        visited[index] = true
        return dfs(index+arr[index]) || dfs(index-arr[index])
    }

    return dfs(start)
}