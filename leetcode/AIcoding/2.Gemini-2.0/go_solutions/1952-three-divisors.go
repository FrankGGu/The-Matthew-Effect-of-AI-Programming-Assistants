func threeDivisors(n int) bool {
    if n <= 3 {
        return false
    }

    count := 0
    for i := 1; i*i <= n; i++ {
        if n%i == 0 {
            if n/i == i {
                count++
            } else {
                count += 2
            }
        }
    }

    return count == 3
}