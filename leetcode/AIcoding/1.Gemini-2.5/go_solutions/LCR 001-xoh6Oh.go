func divide(dividend int, divisor int) int {
    if dividend == 0 {
        return 0
    }

    // Handle overflow condition: dividend = -2^31, divisor = -1
    // The result would be 2^31, which overflows a 32-bit signed integer.
    // In this case, return