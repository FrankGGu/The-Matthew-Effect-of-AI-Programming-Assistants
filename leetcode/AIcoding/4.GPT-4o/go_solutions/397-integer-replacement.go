func integerReplacement(n int) int {
    count := 0
    for n > 1 {
        if n%2 == 0 {
            n /= 2
        } else {
            if n == 3 || ((n >> 1) & 1) == 0 {
                n--
            } else {
                n++
            }
        }
        count++
    }
    return count
}