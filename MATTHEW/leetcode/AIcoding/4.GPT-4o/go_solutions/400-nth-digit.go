func findNthDigit(n int) int {
    if n < 10 {
        return n
    }

    digit, count, base := 1, 9, 1
    for n > digit*count {
        n -= digit * count
        digit++
        count *= 10
        base *= 10
    }

    num := base + (n-1)/digit
    index := (n - 1) % digit
    return int(strconv.Itoa(num)[index] - '0')
}