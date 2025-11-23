func kWeakestRows(mat [][]int, k int) []int {
    type row struct {
        index int
        soldiers int
    }
    rows := make([]row, len(mat))
    for i, r := range mat {
        count := 0
        for _, v := range r {
            count += v
        }
        rows[i] = row{i, count}
    }
    sort.Slice(rows, func(i, j int) bool {
        if rows[i].soldiers == rows[j].soldiers {
            return rows[i].index < rows[j].index
        }
        return rows[i].soldiers < rows[j].soldiers
    })
    res := make([]int, k)
    for i := 0; i < k; i++ {
        res[i] = rows[i].index
    }
    return res
}