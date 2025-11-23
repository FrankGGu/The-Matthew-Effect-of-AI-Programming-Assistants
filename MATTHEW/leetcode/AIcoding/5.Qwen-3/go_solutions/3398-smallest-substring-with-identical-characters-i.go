package main

func minimumSubstring(s string) string {
    if len(s) == 0 {
        return ""
    }

    charCount := make(map[rune]int)
    left := 0
    minLen := len(s)
    result := s

    for right, char := range s {
        charCount[char]++

        for len(charCount) == 1 {
            currentLen := right - left + 1
            if currentLen < minLen {
                minLen = currentLen
                result = s[left:right+1]
            }
            charCount[rune(s[left])]--
            if charCount[rune(s[left])] == 0 {
                delete(charCount, rune(s[left]))
            }
            left++
        }
    }

    return result
}