func longestPalindrome(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }

    count := make(map[string]int)
    for i := 0; i < n; i++ {
        count[string(s[i])]++
    }

    length := 0
    oddFound := false
    for _, cnt := range count {
        if cnt%2 == 0 {
            length += cnt
        } else {
            length += cnt - 1
            oddFound = true
        }
    }

    if oddFound {
        length++
    }

    return length
}