func maxNiceDivisors(n int) int {
    if n <= 3 {
        return n
    }
    if n%3 == 0 {
        return pow(3, n/3)
    } else if n%3 == 1 {
        return pow(3, n/3-1) * 4
    } else {
        return pow(3, n/3) * 2
    }
}

func pow(x, n int) int {
    result := 1
    for n > 0 {
        if n%2 == 1 {
            result = (result * x) % (1e9 + 7)
        }
        x = (x * x) % (1e9 + 7)
        n /= 2
    }
    return result
}