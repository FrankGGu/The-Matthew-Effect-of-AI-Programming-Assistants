package main

func maxFreq(s string, maxLetters int, minSize int, maxSize int) int {
    count := make(map[string]int)
    max := 0
    for i := 0; i <= len(s)-minSize; i++ {
        substr := s[i : i+minSize]
        if isValid(substr, maxLetters) {
            count[substr]++
            if count[substr] > max {
                max = count[substr]
            }
        }
    }
    return max
}

func isValid(s string, maxLetters int) bool {
    set := make(map[rune]bool)
    for _, c := range s {
        set[c] = true
    }
    return len(set) <= maxLetters
}