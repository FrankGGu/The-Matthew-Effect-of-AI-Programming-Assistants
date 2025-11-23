package main

func discountPrices(s string, d int) string {
    words := strings.Split(s, " ")
    for i := 0; i < len(words); i++ {
        if len(words[i]) > 1 && words[i][0] == '$' && isAllDigits(words[i][1:]) {
            price, _ := strconv.Atoi(words[i][1:])
            discounted := price * (100 - d)
            words[i] = "$" + strconv.Itoa(discounted)
        }
    }
    return strings.Join(words, " ")
}

func isAllDigits(s string) bool {
    for _, c := range s {
        if c < '0' || c > '9' {
            return false
        }
    }
    return true
}