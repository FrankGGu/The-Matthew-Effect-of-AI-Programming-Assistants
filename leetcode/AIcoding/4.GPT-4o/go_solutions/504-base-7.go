func convertToBase7(num int) string {
    if num == 0 {
        return "0"
    }
    result := ""
    isNegative := num < 0
    if isNegative {
        num = -num
    }
    for num > 0 {
        result = strconv.Itoa(num % 7) + result
        num /= 7
    }
    if isNegative {
        result = "-" + result
    }
    return result
}