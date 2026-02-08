func deleteDuplicateRows(matrix [][]int) [][]int {
    seen := make(map[string]bool)
    result := [][]int{}

    for _, row := range matrix {
        key := fmt.Sprintf("%v", row)
        if !seen[key] {
            seen[key] = true
            result = append(result, row)
        }
    }

    return result
}