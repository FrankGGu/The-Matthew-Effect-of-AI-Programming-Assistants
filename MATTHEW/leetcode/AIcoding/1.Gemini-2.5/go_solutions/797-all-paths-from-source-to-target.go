func allPathsSourceTarget(graph [][]int) [][]int {
    var result [][]int
    n := len(graph)

    var dfs func(node int, path []int)
    dfs = func(node int, path []int) {
        // Create a new slice for the current path to avoid modification issues
        // when appending to result, as 'path' will be modified during backtracking.
        currentPath := make([]int, len(path))
        copy(currentPath, path)

        if node == n-1 {
            result = append(result, currentPath)
            return
        }

        for _, neighbor := range graph[node] {
            // Append neighbor to the current path for the recursive call
            dfs(neighbor, append(currentPath, neighbor))
        }
    }

    // Start DFS from node 0 with an initial path containing only node 0
    dfs(0, []int{0})

    return result
}