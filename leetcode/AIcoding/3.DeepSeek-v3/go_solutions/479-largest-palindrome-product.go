func largestPalindrome(n int) int {
    if n == 1 {
        return 9
    }
    upper := int(math.Pow10(n)) - 1
    lower := int(math.Pow10(n - 1))
    maxNum := upper * upper
    half := maxNum / int(math.Pow10(n))

    for {
        palin := createPalindrome(half)
        for i := upper; i >= lower; i-- {
            if i*i < palin {
                break
            }
            if palin%i == 0 {
                return palin % 1337
            }
        }
        half--
    }
}

func createPalindrome(half int) int {
    s := strconv.Itoa(half)
    rs := reverseString(s)
    full, _ := strconv.Atoi(s + rs)
    return full
}

func reverseString(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}