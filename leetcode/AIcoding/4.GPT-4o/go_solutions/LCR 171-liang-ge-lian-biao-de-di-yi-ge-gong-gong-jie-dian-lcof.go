func canComplete(n int, dependencies [][]int, k int) bool {
    indegree := make([]int, n)
    graph := make([][]int, n)

    for _, dep := range dependencies {
        graph[dep[1]] = append(graph[dep[1]], dep[0])
        indegree[dep[0]]++
    }

    queue := []int{}
    for i := 0; i < n; i++ {
        if indegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    completed := 0

    for len(queue) > 0 {
        nextQueue := []int{}
        canTake := min(len(queue), k)

        for i := 0; i < canTake; i++ {
            node := queue[i]
            completed++
            for _, neighbor := range graph[node] {
                indegree[neighbor]--
                if indegree[neighbor] == 0 {
                    nextQueue = append(nextQueue, neighbor)
                }
            }
        }

        queue = nextQueue
    }

    return completed == n
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}