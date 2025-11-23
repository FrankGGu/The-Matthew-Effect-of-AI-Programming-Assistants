func findGoodSubset(matrix [][]int) [][]int {
    n := len(matrix)
    if n == 0 {
        return [][]int{}
    }
    m := len(matrix[0])
    goodSubset := [][]int{}

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if matrix[i][j] > 0 {
                goodSubset = append(goodSubset, []int{matrix[i][j]})
            }
        }
    }

    return goodSubset
}