func numSubmatrixSumTarget(matrix [][]int, target int) int {
    m, n := len(matrix), len(matrix[0])
    prefix := make([][]int, m+1)
    for i := range prefix {
        prefix[i] = make([]int, n+1)
    }
    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            prefix[i][j] = prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1] + matrix[i-1][j-1]
        }
    }

    res := 0
    for r1 := 1; r1 <= m; r1++ {
        for r2 := r1; r2 <= m; r2++ {
            count := make(map[int]int)
            count[0] = 1
            sum := 0
            for c := 1; c <= n; c++ {
                sum = prefix[r2][c] - prefix[r1-1][c]
                res += count[sum - target]
                count[sum]++
            }
        }
    }
    return res
}