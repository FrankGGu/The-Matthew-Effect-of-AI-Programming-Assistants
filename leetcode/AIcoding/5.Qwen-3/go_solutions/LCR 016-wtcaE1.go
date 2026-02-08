package main

func lengthOfLongestSubstring(s string) int {
    lastOccurrence := make(map[rune]int)
    maxLength := 0
    start := 0

    for i, char := range s {
        if prev, found := lastOccurrence[char]; found && prev >= start {
            start = prev + 1
        }
        lastOccurrence[char] = i
        if i - start + 1 > maxLength {
            maxLength = i - start + 1
        }
    }

    return maxLength
}