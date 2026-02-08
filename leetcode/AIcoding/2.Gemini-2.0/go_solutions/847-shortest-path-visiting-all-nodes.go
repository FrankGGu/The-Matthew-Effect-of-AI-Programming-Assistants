func shortestPathLength(graph [][]int) int {
    n := len(graph)
    if n == 1 {
        return 0
    }

    queue := make([][]int, 0)
    visited := make([][]bool, n)
    for i := 0; i < n; i++ {
        visited[i] = make([]bool, 1<<n)
        queue = append(queue, []int{i, 1 << i, 0})
        visited[i][1<<i] = true
    }

    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]
        node, mask, dist := curr[0], curr[1], curr[2]

        for _, neighbor := range graph[node] {
            newMask := mask | (1 << neighbor)
            if newMask == (1<<n - 1) {
                return dist + 1
            }

            if !visited[neighbor][newMask] {
                visited[neighbor][newMask] = true
                queue = append(queue, []int{neighbor, newMask, dist + 1})
            }
        }
    }

    return 0
}