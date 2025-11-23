package main

func longestPalindrome(words []string) int {
    count := make(map[string]int)
    for _, word := range words {
        count[word]++
    }
    maxLen := 0
    hasMiddle := false
    for word, cnt := range count {
        reverse := string(word[1]) + string(word[0])
        if word == reverse {
            if cnt%2 == 1 {
                maxLen += (cnt - 1) * 2
                hasMiddle = true
            } else {
                maxLen += cnt * 2
            }
        } else {
            if revCnt, ok := count[reverse]; ok {
                maxLen += min(cnt, revCnt)*2
                delete(count, reverse)
            }
        }
    }
    if hasMiddle {
        maxLen += 2
    }
    return maxLen
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}