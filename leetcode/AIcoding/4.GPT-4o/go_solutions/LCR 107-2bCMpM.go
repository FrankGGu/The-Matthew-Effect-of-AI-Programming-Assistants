func updateMatrix(mat [][]int) [][]int {
    rows, cols := len(mat), len(mat[0])
    directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    queue := [][]int{}

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if mat[i][j] == 0 {
                queue = append(queue, []int{i, j})
            } else {
                mat[i][j] = -1
            }
        }
    }

    distance := 0
    for len(queue) > 0 {
        distance++
        for size := len(queue); size > 0; size-- {
            front := queue[0]
            queue = queue[1:]

            for _, dir := range directions {
                x, y := front[0]+dir[0], front[1]+dir[1]
                if x >= 0 && x < rows && y >= 0 && y < cols && mat[x][y] == -1 {
                    mat[x][y] = distance
                    queue = append(queue, []int{x, y})
                }
            }
        }
    }

    return mat
}