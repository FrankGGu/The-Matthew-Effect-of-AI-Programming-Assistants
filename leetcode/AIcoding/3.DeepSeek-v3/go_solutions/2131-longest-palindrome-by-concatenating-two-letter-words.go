func longestPalindrome(words []string) int {
    freq := make(map[string]int)
    for _, word := range words {
        freq[word]++
    }

    res := 0
    central := false

    for word, count := range freq {
        if word[0] == word[1] {
            if count % 2 == 0 {
                res += count
            } else {
                res += count - 1
                central = true
            }
        } else {
            reversed := string([]byte{word[1], word[0]})
            if reversedCount, exists := freq[reversed]; exists && word < reversed {
                res += 2 * min(count, reversedCount)
            }
        }
    }

    if central {
        res++
    }

    return res * 2
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}