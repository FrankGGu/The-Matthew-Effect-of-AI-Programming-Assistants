func findNthDigit(n int) int {
    digits := 1
    base := 9
    for n > digits*base {
        n -= digits * base
        digits++
        base *= 10
    }
    num := (n - 1) / digits + pow(10, digits-1)
    idx := (n - 1) % digits
    return int(strconv.Itoa(num)[idx] - '0')
}

func pow(a, b int) int {
    res := 1
    for i := 0; i < b; i++ {
        res *= a
    }
    return res
}