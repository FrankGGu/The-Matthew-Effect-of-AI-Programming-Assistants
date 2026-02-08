package main

func capitalizeTitle(s string) string {
    runes := []rune(s)
    n := len(runes)
    for i := 0; i < n; i++ {
        if i == 0 || (i > 0 && runes[i-1] == ' ') {
            runes[i] = unicode.ToUpper(runes[i])
        } else {
            runes[i] = unicode.ToLower(runes[i])
        }
    }
    return string(runes)
}