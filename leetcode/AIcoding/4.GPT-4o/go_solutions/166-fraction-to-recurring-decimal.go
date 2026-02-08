func fractionToDecimal(numerator int, denominator int) string {
    if numerator == 0 {
        return "0"
    }

    result := ""
    if (numerator < 0) != (denominator < 0) {
        result += "-"
    }

    numerator = abs(numerator)
    denominator = abs(denominator)

    integerPart := numerator / denominator
    result += strconv.Itoa(integerPart)

    remainder := numerator % denominator
    if remainder == 0 {
        return result
    }

    result += "."
    remainderMap := make(map[int]int)

    for remainder != 0 {
        if idx, found := remainderMap[remainder]; found {
            result = result[:idx] + "(" + result[idx:] + ")"
            break
        }
        remainderMap[remainder] = len(result)
        remainder *= 10
        result += strconv.Itoa(remainder / denominator)
        remainder %= denominator
    }

    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}