func smallestPalindromic(s string) string {
    count := make([]int, 10)
    for _, ch := range s {
        count[ch-'0']++
    }

    oddCount := 0
    var oddDigit byte
    for i := 0; i < 10; i++ {
        if count[i]%2 == 1 {
            oddCount++
            oddDigit = byte(i + '0')
        }
    }

    if oddCount > 1 {
        return ""
    }

    half := []byte{}
    for i := 0; i < 10; i++ {
        if count[i] > 0 {
            half = append(half, byte(i+'0'))
        }
    }

    result := []byte{}
    for _, digit := range half {
        result = append(result, digit)
        count[digit-'0']--
    }

    palindrome := string(result)
    if oddCount == 1 {
        palindrome += string(oddDigit)
    }
    for i := len(result) - 1; i >= 0; i-- {
        palindrome += string(result[i])
    }

    return palindrome
}