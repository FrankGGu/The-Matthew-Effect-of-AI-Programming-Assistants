func maskPII(S string) string {
    if strings.Contains(S, "@") {
        return maskEmail(S)
    }
    return maskPhone(S)
}

func maskEmail(email string) string {
    parts := strings.Split(email, "@")
    name := parts[0]
    domain := parts[1]
    if len(name) > 2 {
        name = string(name[0]) + "*****" + string(name[len(name)-1])
    } else {
        name = string(name[0]) + "*****"
    }
    return strings.ToLower(name + "@" + strings.ToLower(domain))
}

func maskPhone(phone string) string {
    digits := []rune{}
    for _, ch := range phone {
        if unicode.IsDigit(ch) {
            digits = append(digits, ch)
        }
    }
    n := len(digits)
    masked := "***-***-" + string(digits[n-4:n])
    return "+" + string(digits[0]) + string(digits[1]) + string(digits[2]) + "-" + masked
}