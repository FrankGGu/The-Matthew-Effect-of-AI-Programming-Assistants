package main

func longestPalindrome(s string) int {
    if len(s) == 0 {
        return 0
    }

    charCount := make(map[rune]int)
    for _, c := range s {
        charCount[c]++
    }

    length := 0
    hasOdd := false

    for _, count := range charCount {
        if count%2 == 0 {
            length += count
        } else {
            length += count - 1
            hasOdd = true
        }
    }

    if hasOdd {
        length++
    }

    return length
}