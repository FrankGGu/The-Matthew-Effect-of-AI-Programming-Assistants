func selectData(students [][]interface{}) [][]interface{} {
    var result [][]interface{}
    for _, student := range students {
        if student[1] == "Physics" {
            result = append(result, []interface{}{student[0], student[2]})
        }
    }
    return result
}