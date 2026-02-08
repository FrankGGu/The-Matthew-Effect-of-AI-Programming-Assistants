func longestPalindrome(words [][]string) int {
    count := make(map[string]int)
    for _, word := range words {
        count[word[0:2]]++
    }

    length := 0
    hasMiddle := false

    for word, cnt := range count {
        if word[0] == word[1] {
            length += (cnt / 2) * 4
            if cnt%2 == 1 {
                hasMiddle = true
            }
        } else {
            revWord := string(word[1]) + string(word[0])
            if cntRev, exists := count[revWord]; exists {
                length += min(cnt, cntRev) * 4
            }
        }
    }

    if hasMiddle {
        length += 2
    }

    return length
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}