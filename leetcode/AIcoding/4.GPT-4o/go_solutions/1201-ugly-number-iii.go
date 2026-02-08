func nthUglyNumber(n int, a int, b int, c int) int {
    lcm := func(x, y int) int {
        return x / gcd(x, y) * y
    }
    gcd := func(x, y int) int {
        for y != 0 {
            x, y = y, x%y
        }
        return x
    }

    lcm_ab := lcm(a, b)
    lcm_ac := lcm(a, c)
    lcm_bc := lcm(b, c)
    lcm_abc := lcm(lcm_ab, c)

    left, right := 1, int(1e18)
    for left < right {
        mid := left + (right-left)/2
        count := mid/a + mid/b + mid/c - mid/lcm_ab - mid/lcm_ac - mid/lcm_bc + mid/lcm_abc
        if count < n {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}