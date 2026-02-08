func countVisitedNodes(edges []int) []int {
    n := len(edges)
    ans := make([]int, n)
    visitedState := make([]int, n) // 0: unvisited, 1: visiting (in current path), 2: visited and processed

    for i := 0; i < n; i++ {
        if ans[i] == 0 {
            dfs(i, edges, ans, visitedState, []int{})
        }
    }
    return ans
}

func dfs(u int, edges []int, ans []int, visitedState []int, currentPath []int) int {
    if ans[u] != 0 {
        return ans[u]
    }

    if visitedState[u] == 1 { // Cycle detected
        cycleStartIdx := -1
        for i, node := range currentPath {
            if node == u {
                cycleStartIdx = i
                break
            }
        }
        cycleLen := len(currentPath) - cycleStartIdx

        for i := cycleStartIdx; i < len(currentPath); i++ {
            ans[currentPath[i]] = cycleLen
        }
        return cycleLen
    }

    visitedState[u] = 1
    currentPath = append(currentPath, u)

    v := edges[u]
    countFromV := dfs(v, edges, ans, visitedState, currentPath)

    currentPath = currentPath[:len(currentPath)-1] // Backtrack

    if ans[u] == 0 { // If u was not part of a cycle detected in the recursive call
        ans[u] = 1 + countFromV
    }

    visitedState[u] = 2
    return ans[u]
}