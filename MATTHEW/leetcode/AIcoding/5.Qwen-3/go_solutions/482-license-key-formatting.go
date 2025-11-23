package main

func licenseKeyFormatting(s string) string {
    s = strings.ReplaceAll(s, "-", "")
    s = strings.ToUpper(s)
    n := len(s)
    if n == 0 {
        return ""
    }
    var result strings.Builder
    for i := n - 1; i >= 0; i-- {
        if (n-i)%4 == 0 && i != n-1 {
            result.WriteRune('-')
        }
        result.WriteRune(rune(s[i]))
    }
    return reverseString(result.String())
}

func reverseString(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}