func isThree(n int) bool {
    if n < 4 {
        return false
    }
    sqrt := int(math.Sqrt(float64(n)))
    if sqrt*sqrt != n {
        return false
    }
    for i := 2; i*i <= sqrt; i++ {
        if sqrt%i == 0 {
            return false
        }
    }
    return true
}