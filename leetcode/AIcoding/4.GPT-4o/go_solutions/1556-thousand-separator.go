func thousandSeparator(n int) string {
    if n == 0 {
        return "0"
    }
    result := ""
    count := 0
    for n > 0 {
        if count > 0 && count%3 == 0 {
            result = "." + result
        }
        result = strconv.Itoa(n%10) + result
        n /= 10
        count++
    }
    return result
}