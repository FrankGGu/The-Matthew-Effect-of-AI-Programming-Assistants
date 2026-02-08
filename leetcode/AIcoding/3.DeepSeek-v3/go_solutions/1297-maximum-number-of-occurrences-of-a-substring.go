func maxFreq(s string, maxLetters int, minSize int, maxSize int) int {
    count := make(map[string]int)
    maxCount := 0
    n := len(s)

    for i := 0; i <= n - minSize; i++ {
        substr := s[i:i+minSize]
        letters := make(map[rune]bool)
        valid := true

        for _, c := range substr {
            letters[c] = true
            if len(letters) > maxLetters {
                valid = false
                break
            }
        }

        if valid {
            count[substr]++
            if count[substr] > maxCount {
                maxCount = count[substr]
            }
        }
    }

    return maxCount
}