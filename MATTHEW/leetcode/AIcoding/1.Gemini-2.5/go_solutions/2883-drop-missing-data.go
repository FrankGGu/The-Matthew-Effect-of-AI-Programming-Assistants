func dropMissingData(data [][]int) [][]int {
    var result [][]int

    for _, row := range data {
        hasMissing := false
        for _, val := range row {
            if val == 0 { // Assuming 0 represents missing data
                hasMissing = true
                break
            }
        }
        if !hasMissing {
            result = append(result, row)
        }
    }

    return result
}