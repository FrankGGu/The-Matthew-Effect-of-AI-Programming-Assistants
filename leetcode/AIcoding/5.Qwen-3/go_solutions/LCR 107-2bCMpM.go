package main

func updateMatrix(mat [][]int) [][]int {
    m := len(mat)
    n := len(mat[0])
    queue := [][]int{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if mat[i][j] == 0 {
                queue = append(queue, []int{i, j})
            } else {
                mat[i][j] = -1
            }
        }
    }
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for len(queue) > 0 {
        cell := queue[0]
        queue = queue[1:]
        for _, dir := range directions {
            x := cell[0] + dir[0]
            y := cell[1] + dir[1]
            if x >= 0 && x < m && y >= 0 && y < n && mat[x][y] == -1 {
                mat[x][y] = mat[cell[0]][cell[1]] + 1
                queue = append(queue, []int{x, y})
            }
        }
    }
    return mat
}