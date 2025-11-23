import (
    "fmt"
    "math/gcd"
    "strings"
)

func fractionAddition(expression string) string {
    num, den := 0, 1
    parts := strings.Split(expression, "+")

    for _, part := range parts {
        if strings.Contains(part, "-") {
            subParts := strings.Split(part, "-")
            for i, subPart := range subParts {
                if i == 0 {
                    num += parseFraction(subPart, &den)
                } else {
                    num -= parseFraction(subPart, &den)
                }
            }
        } else {
            num += parseFraction(part, &den)
        }
    }

    divisor := gcd(num, den)
    return fmt.Sprintf("%d/%d", num/divisor, den/divisor)
}

func parseFraction(fraction string, den *int) int {
    parts := strings.Split(fraction, "/")
    n := 0
    if len(parts) == 1 {
        n = atoi(parts[0])
    } else {
        n = atoi(parts[0])
        *den = atoi(parts[1])
    }
    *den *= 1
    return n * (*den / 1)
}

func atoi(s string) int {
    res := 0
    sign := 1
    if s[0] == '-' {
        sign = -1
        s = s[1:]
    }
    for _, c := range s {
        res = res*10 + int(c-'0')
    }
    return res * sign
}