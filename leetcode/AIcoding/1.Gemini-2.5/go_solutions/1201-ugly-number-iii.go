func nthUglyNumber(n int, a int, b int, c int) int {
    low, high := 1, 2*1e9
    ab := lcm(a, b)
    ac := lcm(a, c)
    bc := lcm(b, c)
    abc := lcm(ab, c)

    for low < high {
        mid := low + (high-low)/2
        count := mid/a + mid/b + mid/c - mid/ab - mid/ac - mid/bc + mid/abc
        if count < n {
            low = mid + 1
        } else {
            high = mid
        }
    }
    return low
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}

func lcm(a, b int) int {
    return a * b / gcd(a, b)
}