func fractionToDecimal(numerator int, denominator int) string {
    if numerator == 0 {
        return "0"
    }

    var res []byte
    if (numerator < 0) != (denominator < 0) {
        res = append(res, '-')
    }

    num := abs(numerator)
    den := abs(denominator)

    res = append(res, strconv.Itoa(num / den)...)
    remainder := num % den
    if remainder == 0 {
        return string(res)
    }

    res = append(res, '.')
    m := make(map[int]int)
    for remainder != 0 {
        if pos, ok := m[remainder]; ok {
            res = append(res[:pos], append([]byte{'('}, res[pos:]...)...)
            res = append(res, ')')
            break
        }
        m[remainder] = len(res)
        remainder *= 10
        res = append(res, strconv.Itoa(remainder / den)...)
        remainder %= den
    }
    return string(res)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}