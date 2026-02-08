func updateMatrix(mat [][]int) [][]int {
    rows, cols := len(mat), len(mat[0])
    dist := make([][]int, rows)
    for i := range dist {
        dist[i] = make([]int, cols)
        for j := range dist[i] {
            dist[i][j] = int(1e4)
        }
    }

    queue := make([][2]int, 0)
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if mat[i][j] == 0 {
                dist[i][j] = 0
                queue = append(queue, [2]int{i, j})
            }
        }
    }

    directions := [][2]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

    for len(queue) > 0 {
        cell := queue[0]
        queue = queue[1:]
        for _, d := range directions {
            r, c := cell[0]+d[0], cell[1]+d[1]
            if r >= 0 && r < rows && c >= 0 && c < cols && dist[r][c] > dist[cell[0]][cell[1]]+1 {
                dist[r][c] = dist[cell[0]][cell[1]] + 1
                queue = append(queue, [2]int{r, c})
            }
        }
    }

    return dist
}