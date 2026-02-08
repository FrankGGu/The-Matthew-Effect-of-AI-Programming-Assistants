func diagonalSum(mat [][]int) int {
    n := len(mat)
    sum := 0
    for i := 0; i < n; i++ {
        sum += mat[i][i] // 主对角线
        sum += mat[i][n-1-i] // 副对角线
    }
    if n%2 == 1 {
        sum -= mat[n/2][n/2] // 如果是奇数，减去中心元素
    }
    return sum
}