func divide(dividend int, divisor int) int {
    if dividend == math.MinInt32 && divisor == -1 {
        return math.MaxInt32
    }

    negative := (dividend < 0) != (divisor < 0)
    dividend = abs(dividend)
    divisor = abs(divisor)

    result := 0
    for dividend >= divisor {
        tempDivisor, multiple := divisor, 1
        for dividend >= (tempDivisor << 1) {
            if tempDivisor << 1 <= 0 {
                break
            }
            tempDivisor <<= 1
            multiple <<= 1
        }
        dividend -= tempDivisor
        result += multiple
    }

    if negative {
        result = -result
    }

    if result > math.MaxInt32 {
        return math.MaxInt32
    }
    if result < math.MinInt32 {
        return math.MinInt32
    }

    return result
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}