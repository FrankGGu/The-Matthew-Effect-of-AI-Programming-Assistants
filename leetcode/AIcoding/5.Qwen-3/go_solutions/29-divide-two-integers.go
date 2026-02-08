package main

func divide(dividend int, divisor int) int {
    if divisor == 1 {
        return dividend
    }
    if divisor == -1 {
        if dividend > math.MaxInt32 {
            return math.MaxInt32
        }
        if dividend < math.MinInt32 {
            return math.MinInt32
        }
        return -dividend
    }
    sign := 1
    if (dividend < 0) != (divisor < 0) {
        sign = -1
    }
    a, b := abs(dividend), abs(divisor)
    result := 0
    for a >= b {
        shift := 0
        for a >= (b << shift) {
            shift++
        }
        result += 1 << (shift - 1)
        a -= b << (shift - 1)
    }
    return sign * result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}