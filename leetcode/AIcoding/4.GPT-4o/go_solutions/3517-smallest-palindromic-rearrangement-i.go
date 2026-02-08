func smallestPalindromic(s string) string {
    count := [10]int{}
    for _, ch := range s {
        count[ch-'0']++
    }

    half := ""
    odd := ""

    for i := 0; i < 10; i++ {
        if count[i] % 2 == 1 {
            if odd == "" || odd > string(i+'0') {
                odd = string(i + '0')
            }
        }
        half += strings.Repeat(string(i+'0'), count[i]/2)
    }

    if half == "" && odd == "" {
        return "0"
    }

    if half == "" {
        return odd
    }

    result := half
    if odd != "" {
        result += odd
    }
    for i := len(half) - 1; i >= 0; i-- {
        result += string(half[i])
    }

    return result
}