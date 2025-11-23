func maximumDetonation(bombs [][]int) int {
    n := len(bombs)
    graph := make([][]int, n)

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if i == j {
                continue
            }
            xi, yi, ri := bombs[i][0], bombs[i][1], bombs[i][2]
            xj, yj := bombs[j][0], bombs[j][1]
            dx := xi - xj
            dy := yi - yj
            if int64(dx)*int64(dx) + int64(dy)*int64(dy) <= int64(ri)*int64(ri) {
                graph[i] = append(graph[i], j)
            }
        }
    }

    max := 0
    for i := 0; i < n; i++ {
        visited := make([]bool, n)
        queue := []int{i}
        visited[i] = true
        count := 0

        for len(queue) > 0 {
            node := queue[0]
            queue = queue[1:]
            count++

            for _, neighbor := range graph[node] {
                if !visited[neighbor] {
                    visited[neighbor] = true
                    queue = append(queue, neighbor)
                }
            }
        }

        if count > max {
            max = count
        }
    }

    return max
}