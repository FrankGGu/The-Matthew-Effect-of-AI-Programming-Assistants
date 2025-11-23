func isThree(n int) bool {
    if n < 1 {
        return false
    }
    count := 0
    for i := 1; i*i <= n; i++ {
        if n%i == 0 {
            count++
            if i*i != n {
                count++
            }
        }
        if count > 3 {
            return false
        }
    }
    return count == 3
}