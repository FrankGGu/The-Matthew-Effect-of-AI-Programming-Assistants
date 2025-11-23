package main

func maskPII(email string) string {
    if strings.Contains(email, "@") {
        at := strings.Index(email, "@")
        local := email[:at]
        domain := email[at:]
        local = strings.ToLower(local)
        local = local[:1] + "*****" + local[len(local)-1:]
        return local + domain
    } else {
        digits := ""
        for _, c := range email {
            if unicode.IsDigit(c) {
                digits += string(c)
            }
        }
        length := len(digits)
        return "+***-***-" + digits[length-4:]
    }
}