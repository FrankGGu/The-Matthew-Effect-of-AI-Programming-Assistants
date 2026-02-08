func deepDarkFraction(numerator int, denominator int) string {
    if denominator == 0 {
        return "undefined"
    }

    if numerator == 0 {
        return "0/1"
    }

    sign := ""
    if (numerator < 0) != (denominator < 0) {
        sign = "-"
    }

    numerator = abs(numerator)
    denominator = abs(denominator)

    gcd := gcd(numerator, denominator)
    numerator /= gcd
    denominator /= gcd

    return sign + strconv.Itoa(numerator) + "/" + strconv.Itoa(denominator)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func gcd(a int, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}