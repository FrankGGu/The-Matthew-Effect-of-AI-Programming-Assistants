func countPaths(matrix [][]int, k int) int {
    m, n := len(matrix), len(matrix[0])
    mod := make([][][]int, m)
    for i := range mod {
        mod[i] = make([][]int, n)
        for j := range mod[i] {
            mod[i][j] = make([]int, k)
        }
    }
    mod[0][0][matrix[0][0]%k] = 1

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            for sum := 0; sum < k; sum++ {
                if i > 0 {
                    mod[i][j][(sum+matrix[i][j])%k] += mod[i-1][j][sum]
                }
                if j > 0 {
                    mod[i][j][(sum+matrix[i][j])%k] += mod[i][j-1][sum]
                }
            }
        }
    }

    return mod[m-1][n-1][0]
}