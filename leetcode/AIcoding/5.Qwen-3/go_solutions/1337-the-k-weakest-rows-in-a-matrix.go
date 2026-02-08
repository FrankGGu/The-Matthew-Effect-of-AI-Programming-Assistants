package main

func kWeakestRows(mat [][]int, k int) []int {
    rows := make([][]int, len(mat))
    for i := range mat {
        count := 0
        for j := range mat[i] {
            if mat[i][j] == 1 {
                count++
            }
        }
        rows[i] = []int{count, i}
    }

    sort.Slice(rows, func(i, j int) bool {
        if rows[i][0] != rows[j][0] {
            return rows[i][0] < rows[j][0]
        }
        return rows[i][1] < rows[j][1]
    })

    result := make([]int, k)
    for i := 0; i < k; i++ {
        result[i] = rows[i][1]
    }
    return result
}