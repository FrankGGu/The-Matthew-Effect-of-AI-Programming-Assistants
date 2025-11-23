func convertToTitle(columnNumber int) string {
    result := ""
    for columnNumber > 0 {
        columnNumber-- // Adjust for 0-indexing
        result = string('A'+(columnNumber%26)) + result
        columnNumber /= 26
    }
    return result
}