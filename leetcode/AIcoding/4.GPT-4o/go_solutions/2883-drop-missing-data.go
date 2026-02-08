func dropMissingData(df [][]interface{}) [][]interface{} {
    var result [][]interface{}

    for _, row := range df {
        hasMissing := false
        for _, val := range row {
            if val == nil {
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