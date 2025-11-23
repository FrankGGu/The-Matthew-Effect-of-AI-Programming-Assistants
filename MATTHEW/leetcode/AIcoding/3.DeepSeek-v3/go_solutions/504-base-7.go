func convertToBase7(num int) string {
    if num == 0 {
        return "0"
    }
    negative := false
    if num < 0 {
        negative = true
        num = -num
    }
    res := ""
    for num > 0 {
        res = string('0' + num % 7) + res
        num /= 7
    }
    if negative {
        res = "-" + res
    }
    return res
}