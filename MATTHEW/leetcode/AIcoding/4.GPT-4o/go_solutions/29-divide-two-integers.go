func divide(dividend int, divisor int) int {
    if dividend == math.MinInt32 && divisor == -1 {
        return math.MaxInt32
    }

    sign := 1
    if (dividend < 0) != (divisor < 0) {
        sign = -1
    }

    dividend, divisor = abs(dividend), abs(divisor)
    quotient := 0

    for dividend >= divisor {
        temp, multiple := divisor, 1
        for dividend >= (temp << 1) {
            temp <<= 1
            multiple <<= 1
        }
        dividend -= temp
        quotient += multiple
    }

    if sign == -1 {
        quotient = -quotient
    }

    return quotient
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}