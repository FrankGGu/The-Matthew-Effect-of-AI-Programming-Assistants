func convertToTitle(columnNumber int) string {
    var result []byte
    for columnNumber > 0 {
        columnNumber--
        remainder := columnNumber % 26
        result = append([]byte{byte('A' + remainder)}, result...)
        columnNumber /= 26
    }
    return string(result)
}