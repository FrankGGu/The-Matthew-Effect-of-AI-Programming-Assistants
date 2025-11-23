func dropDuplicateRows(rows [][]int) [][]int {
    seen := make(map[string]bool)
    result := [][]int{}
    for _, row := range rows {
        key := ""
        for _, num := range row {
            key += fmt.Sprintf("%d,", num)
        }
        if !seen[key] {
            seen[key] = true
            result = append(result, row)
        }
    }
    return result
}