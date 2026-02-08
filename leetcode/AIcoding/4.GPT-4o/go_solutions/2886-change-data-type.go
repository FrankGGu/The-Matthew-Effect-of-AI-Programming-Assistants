func changeDataType(num int) string {
    if num == 0 {
        return "0"
    }
    if num > 0 {
        return "Positive"
    }
    return "Negative"
}