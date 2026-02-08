func findExit(maze [][]byte, start []int) []int {
    if len(maze) == 0 || len(maze[0]) == 0 {
        return []int{-1, -1}
    }

    m, n := len(maze), len(maze[0])
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    queue := [][]int{start}
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    visited[start[0]][start[1]] = true

    for len(queue) > 0 {
        cell := queue[0]
        queue = queue[1:]
        i, j := cell[0], cell[1]

        for _, dir := range directions {
            ni, nj := i+dir[0], j+dir[1]
            if ni < 0 || ni >= m || nj < 0 || nj >= n {
                if i != start[0] || j != start[1] {
                    return []int{i, j}
                }
                continue
            }
            if maze[ni][nj] == '.' && !visited[ni][nj] {
                visited[ni][nj] = true
                queue = append(queue, []int{ni, nj})
            }
        }
    }
    return []int{-1, -1}
}