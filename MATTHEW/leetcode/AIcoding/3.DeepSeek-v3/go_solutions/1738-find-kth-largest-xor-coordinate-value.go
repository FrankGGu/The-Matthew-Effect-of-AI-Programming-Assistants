func kthLargestValue(matrix [][]int, k int) int {
    m, n := len(matrix), len(matrix[0])
    xor := make([][]int, m+1)
    for i := range xor {
        xor[i] = make([]int, n+1)
    }
    var res []int
    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            xor[i][j] = xor[i-1][j] ^ xor[i][j-1] ^ xor[i-1][j-1] ^ matrix[i-1][j-1]
            res = append(res, xor[i][j])
        }
    }
    sort.Sort(sort.Reverse(sort.IntSlice(res)))
    return res[k-1]
}