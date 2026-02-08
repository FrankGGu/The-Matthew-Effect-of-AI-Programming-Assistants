package main

func nthUglyNumber(n int, a int, b int, c int) int {
    left := 1
    right := 2 * 10^9

    for left < right {
        mid := left + (right-left)/2
        count := mid/a + mid/b + mid/c - mid/lcm(a, b) - mid/lcm(a, c) - mid/lcm(b, c) + mid/lcm(lcm(a, b), c)
        if count < n {
            left = mid + 1
        } else {
            right = mid
        }
    }

    return left
}

func lcm(x, y int) int {
    return x * y / gcd(x, y)
}

func gcd(x, y int) int {
    for y != 0 {
        x, y = y, x%y
    }
    return x
}