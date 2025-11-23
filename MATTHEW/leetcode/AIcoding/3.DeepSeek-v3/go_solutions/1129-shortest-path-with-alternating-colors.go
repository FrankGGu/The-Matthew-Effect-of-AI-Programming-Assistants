func shortestAlternatingPaths(n int, redEdges [][]int, blueEdges [][]int) []int {
    redGraph := make([][]int, n)
    blueGraph := make([][]int, n)

    for _, edge := range redEdges {
        from, to := edge[0], edge[1]
        redGraph[from] = append(redGraph[from], to)
    }

    for _, edge := range blueEdges {
        from, to := edge[0], edge[1]
        blueGraph[from] = append(blueGraph[from], to)
    }

    res := make([]int, n)
    for i := 0; i < n; i++ {
        res[i] = -1
    }

    queue := [][]int{{0, 0, -1}}
    visited := make([][]bool, n)
    for i := range visited {
        visited[i] = make([]bool, 2)
    }
    visited[0][0] = true
    visited[0][1] = true

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        current, steps, color := node[0], node[1], node[2]

        if res[current] == -1 {
            res[current] = steps
        }

        if color != 0 {
            for _, neighbor := range redGraph[current] {
                if !visited[neighbor][0] {
                    visited[neighbor][0] = true
                    queue = append(queue, []int{neighbor, steps + 1, 0})
                }
            }
        }

        if color != 1 {
            for _, neighbor := range blueGraph[current] {
                if !visited[neighbor][1] {
                    visited[neighbor][1] = true
                    queue = append(queue, []int{neighbor, steps + 1, 1})
                }
            }
        }
    }

    return res
}