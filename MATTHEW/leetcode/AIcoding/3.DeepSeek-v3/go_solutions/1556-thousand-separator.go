func thousandSeparator(n int) string {
    if n == 0 {
        return "0"
    }
    res := []byte{}
    count := 0
    for n > 0 {
        if count == 3 {
            res = append(res, '.')
            count = 0
        }
        digit := n % 10
        res = append(res, byte('0'+digit))
        n /= 10
        count++
    }
    for i, j := 0, len(res)-1; i < j; i, j = i+1, j-1 {
        res[i], res[j] = res[j], res[i]
    }
    return string(res)
}