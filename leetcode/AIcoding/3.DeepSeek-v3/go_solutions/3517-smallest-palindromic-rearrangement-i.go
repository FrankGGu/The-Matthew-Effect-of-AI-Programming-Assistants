func smallestPalindrome(s string) string {
    freq := make(map[rune]int)
    for _, c := range s {
        freq[c]++
    }

    var oddChar rune
    count := 0
    var half []rune

    for c := 'a'; c <= 'z'; c++ {
        if freq[c]%2 != 0 {
            oddChar = c
            count++
        }
        for i := 0; i < freq[c]/2; i++ {
            half = append(half, c)
        }
    }

    if count > 1 {
        return ""
    }

    var res []rune
    res = append(res, half...)
    if count == 1 {
        res = append(res, oddChar)
    }
    for i := len(half) - 1; i >= 0; i-- {
        res = append(res, half[i])
    }

    return string(res)
}