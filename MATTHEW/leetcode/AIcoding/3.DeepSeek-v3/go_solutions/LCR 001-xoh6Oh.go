func divide(dividend int, divisor int) int {
    if dividend == math.MinInt32 && divisor == -1 {
        return math.MaxInt32
    }

    negative := (dividend < 0) != (divisor < 0)
    absDividend := abs(dividend)
    absDivisor := abs(divisor)

    result := 0

    for absDividend >= absDivisor {
        temp, multiple := absDivisor, 1
        for absDividend >= (temp << 1) {
            if temp << 1 <= 0 {
                break
            }
            temp <<= 1
            multiple <<= 1
        }
        absDividend -= temp
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