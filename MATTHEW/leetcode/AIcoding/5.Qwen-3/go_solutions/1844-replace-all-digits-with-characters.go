package main

func replaceDigits(s string) string {
    runes := []rune(s)
    for i := 1; i < len(runes); i += 2 {
        prev := runes[i-1]
        shift := int(runes[i] - '0')
        runes[i] = prev + rune(shift)
    }
    return string(runes)
}