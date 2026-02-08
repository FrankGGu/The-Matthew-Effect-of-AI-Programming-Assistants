func kWeakestRows(mat [][]int, k int) []int {
    type row struct {
        index int
        count int
    }

    rows := make([]row, len(mat))

    for i := 0; i < len(mat); i++ {
        count := 0
        for _, v := range mat[i] {
            if v == 1 {
                count++
            }
        }
        rows[i] = row{i, count}
    }

    sort.Slice(rows, func(i, j int) bool {
        if rows[i].count == rows[j].count {
            return rows[i].index < rows[j].index
        }
        return rows[i].count < rows[j].count
    })

    result := make([]int, k)
    for i := 0; i < k; i++ {
        result[i] = rows[i].index
    }

    return result
}