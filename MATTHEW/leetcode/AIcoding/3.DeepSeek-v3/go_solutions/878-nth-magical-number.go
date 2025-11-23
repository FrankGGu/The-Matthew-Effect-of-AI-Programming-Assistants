func nthMagicalNumber(n int, a int, b int) int {
    mod := int(1e9 + 7)
    lcm := a * b / gcd(a, b)
    left, right := 0, int(1e18)

    for left < right {
        mid := left + (right - left) / 2
        count := mid/a + mid/b - mid/lcm
        if count < n {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left % mod
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a % b
    }
    return a
}