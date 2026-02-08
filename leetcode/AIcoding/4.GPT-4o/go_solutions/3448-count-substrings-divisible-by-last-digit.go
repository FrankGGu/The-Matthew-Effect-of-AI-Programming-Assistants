func countDivisibleSubstrings(s string) int {
    n := len(s)
    count := 0

    for i := 0; i < n; i++ {
        if s[i] == '0' {
            continue
        }
        lastDigit := int(s[i] - '0')
        num := 0
        for j := i; j < n; j++ {
            num = num*10 + int(s[j]-'0')
            if num%lastDigit == 0 {
                count++
            }
        }
    }

    return count
}