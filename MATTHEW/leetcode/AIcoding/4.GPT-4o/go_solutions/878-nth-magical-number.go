func nthMagicalNumber(n int, a int, b int) int {
    const MOD = 1_000_000_007

    lcm := func(x, y int) int {
        return x / gcd(x, y) * y
    }

    gcd := func(x, y int) int {
        for y != 0 {
            x, y = y, x%y
        }
        return x
    }

    lcmAB := lcm(a, b)
    left, right := 0, n*min(a, b)

    for left < right {
        mid := left + (right-left)/2
        if mid/a+mid/b-mid/lcmAB < n {
            left = mid + 1
        } else {
            right = mid
        }
    }

    return left % MOD
}

func min(x, y int) int {
    if x < y {
        return x
    }
    return y
}