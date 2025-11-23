package main

func countSubstrings(s string) int {
    count := 0
    for i := 0; i < len(s); i++ {
        lastDigit := int(s[i] - '0')
        if lastDigit == 0 {
            continue
        }
        for j := i; j < len(s); j++ {
            num, _ := strconv.Atoi(s[i:j+1])
            if num%lastDigit == 0 {
                count++
            }
        }
    }
    return count
}