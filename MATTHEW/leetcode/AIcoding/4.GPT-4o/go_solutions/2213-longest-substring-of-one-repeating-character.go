func maxRepOpt1(text string) int {
    count := make(map[rune]int)
    for _, char := range text {
        count[char]++
    }

    maxLen := 0
    n := len(text)

    for i := 0; i < n; {
        j := i
        for j < n && text[i] == text[j] {
            j++
        }
        lenSame := j - i
        maxLen = max(maxLen, lenSame)

        if j < n {
            nextChar := text[j]
            if count[rune(text[i])] > lenSame {
                maxLen = max(maxLen, lenSame + 1)
            }
        }

        i = j
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}