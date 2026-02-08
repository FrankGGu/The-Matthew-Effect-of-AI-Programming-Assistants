package main

func updateMatrix(mat [][]int) [][]int {
    m := len(mat)
    n := len(mat[0])
    q := [][]int{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if mat[i][j] == 0 {
                q = append(q, []int{i, j})
            } else {
                mat[i][j] = -1
            }
        }
    }
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for len(q) > 0 {
        cell := q[0]
        q = q[1:]
        for _, d := range dirs {
            x := cell[0] + d[0]
            y := cell[1] + d[1]
            if x >= 0 && x < m && y >= 0 && y < n && mat[x][y] == -1 {
                mat[x][y] = mat[cell[0]][cell[1]] + 1
                q = append(q, []int{x, y})
            }
        }
    }
    return mat
}