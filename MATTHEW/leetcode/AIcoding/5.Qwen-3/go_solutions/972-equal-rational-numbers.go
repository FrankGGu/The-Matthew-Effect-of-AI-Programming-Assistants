package main

func isRationalEqual(s string, t string) bool {
    var parse func(string) (int, int)
    parse = func(s string) (int, int) {
        if s[0] == '(' {
            s = s[1 : len(s)-1]
        }
        dot := -1
        for i := 0; i < len(s); i++ {
            if s[i] == '.' {
                dot = i
                break
            }
        }
        if dot == -1 {
            return 0, 1
        }
        integerPart := s[:dot]
        decimalPart := s[dot+1:]
        if decimalPart == "" {
            return 0, 1
        }
        length := len(decimalPart)
        numerator := 0
        denominator := 1
        for i := 0; i < length; i++ {
            numerator = numerator*10 + int(decimalPart[i]-'0')
            denominator *= 10
        }
        if integerPart != "" {
            for i := 0; i < len(integerPart); i++ {
                numerator = numerator*10 + int(integerPart[i]-'0')
            }
        }
        return numerator, denominator
    }
    a, b := parse(s)
    c, d := parse(t)
    return a*d == c*b
}