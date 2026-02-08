func findDiagonalOrder(mat [][]int) []int {
    if len(mat) == 0 || len(mat[0]) == 0 {
        return []int{}
    }
    m, n := len(mat), len(mat[0])
    result := make([]int, 0, m*n)
    for s := 0; s < m+n-1; s++ {
        if s%2 == 0 {
            for i := min(s, m-1); i >= max(0, s-n+1); i-- {
                j := s - i
                result = append(result, mat[i][j])
            }
        } else {
            for j := min(s, n-1); j >= max(0, s-m+1); j-- {
                i := s - j
                result = append(result, mat[i][j])
            }
        }
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}