func longestSemiRepetitiveSubstring(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }

    left, right := 0, 0
    maxLength := 0
    count := 0

    for right < n {
        if right > 0 && s[right] == s[right-1] {
            count++
        }

        for count > 1 {
            if s[left] == s[left+1] {
                count--
            }
            left++
        }

        maxLength = max(maxLength, right-left+1)
        right++
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}