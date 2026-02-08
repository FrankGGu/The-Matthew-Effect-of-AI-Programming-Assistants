func extractMantra(matrix []string, mantra string) int {
    m, n := len(matrix), len(matrix[0])
    l := len(mantra)
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    queue := [][]int{}
    visited := make([][][]bool, m)
    for i := range visited {
        visited[i] = make([][]bool, n)
        for j := range visited[i] {
            visited[i][j] = make([]bool, l+1)
        }
    }

    if matrix[0][0] == mantra[0] {
        if l == 1 {
            return 1
        }
        queue = append(queue, []int{0, 0, 1})
        visited[0][0][1] = true
    } else {
        queue = append(queue, []int{0, 0, 0})
        visited[0][0][0] = true
    }

    steps := 0
    for len(queue) > 0 {
        size := len(queue)
        steps++
        for i := 0; i < size; i++ {
            curr := queue[i]
            x, y, pos := curr[0], curr[1], curr[2]
            for _, d := range dirs {
                nx, ny := x+d[0], y+d[1]
                if nx >= 0 && nx < m && ny >= 0 && ny < n {
                    if pos < l && matrix[nx][ny] == mantra[pos] {
                        if pos+1 == l {
                            return steps + 1
                        }
                        if !visited[nx][ny][pos+1] {
                            visited[nx][ny][pos+1] = true
                            queue = append(queue, []int{nx, ny, pos+1})
                        }
                    }
                    if !visited[nx][ny][pos] {
                        visited[nx][ny][pos] = true
                        queue = append(queue, []int{nx, ny, pos})
                    }
                }
            }
        }
        queue = queue[size:]
    }
    return -1
}