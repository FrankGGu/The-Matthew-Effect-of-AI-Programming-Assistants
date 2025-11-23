package main

func isStrictlyPalindromic(n int) bool {
    for base := 2; base <= n-1; base++ {
        s := ""
        num := n
        for num > 0 {
            s = strconv.Itoa(num%base) + s
            num /= base
        }
        if s != reverse(s) {
            return false
        }
    }
    return true
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}