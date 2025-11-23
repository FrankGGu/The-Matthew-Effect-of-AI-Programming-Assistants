func divide(dividend int, divisor int) int {
    if dividend == math.MinInt32 && divisor == -1 {
        return math.MaxInt32
    }

    sign := 1
    if (dividend < 0 && divisor > 0) || (dividend > 0 && divisor < 0) {
        sign = -1
    }

    absDividend := int(math.Abs(float64(dividend)))
    absDivisor := int(math.Abs(float64(divisor)))

    quotient := 0
    for absDividend >= absDivisor {
        absDividend -= absDivisor
        quotient++
    }

    if sign < 0 {
        quotient = -quotient
    }

    return quotient
}