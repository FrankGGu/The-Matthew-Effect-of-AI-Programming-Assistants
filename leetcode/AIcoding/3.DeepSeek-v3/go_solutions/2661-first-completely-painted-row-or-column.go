func firstCompleteIndex(arr []int, mat [][]int) int {
    m, n := len(mat), len(mat[0])
    pos := make(map[int][2]int)
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            pos[mat[i][j]] = [2]int{i, j}
        }
    }
    rowCnt := make([]int, m)
    colCnt := make([]int, n)
    for k, v := range arr {
        p := pos[v]
        i, j := p[0], p[1]
        rowCnt[i]++
        if rowCnt[i] == n {
            return k
        }
        colCnt[j]++
        if colCnt[j] == m {
            return k
        }
    }
    return -1
}