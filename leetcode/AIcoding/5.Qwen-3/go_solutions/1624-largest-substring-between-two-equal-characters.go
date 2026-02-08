package main

func largestSubstringBetweenTwoEqualCharacters(s string) int {
    maxLen := -1
    firstOccurrence := make(map[rune]int)

    for i, char := range s {
        if _, found := firstOccurrence[char]; found {
            currentLen := i - firstOccurrence[char] - 1
            if currentLen > maxLen {
                maxLen = currentLen
            }
        } else {
            firstOccurrence[char] = i
        }
    }

    return maxLen
}