package main

func simplifiedFractions(n int) []string {
    result := make([]string, 0)
    for denominator := 2; denominator <= n; denominator++ {
        for numerator := 1; numerator < denominator; numerator++ {
            if gcd(numerator, denominator) == 1 {
                result = append(result, strconv.Itoa(numerator)+"/"+strconv.Itoa(denominator))
            }
        }
    }
    return result
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}