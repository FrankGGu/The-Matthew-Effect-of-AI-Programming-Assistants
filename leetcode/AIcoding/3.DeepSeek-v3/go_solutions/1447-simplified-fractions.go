func simplifiedFractions(n int) []string {
    res := []string{}
    for denominator := 2; denominator <= n; denominator++ {
        for numerator := 1; numerator < denominator; numerator++ {
            if gcd(numerator, denominator) == 1 {
                res = append(res, fmt.Sprintf("%d/%d", numerator, denominator))
            }
        }
    }
    return res
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}