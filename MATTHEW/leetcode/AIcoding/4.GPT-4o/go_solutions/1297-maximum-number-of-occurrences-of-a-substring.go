func maxFreq(s string, maxLetters int, minSize int, maxSize int) int {
    freq := make(map[string]int)
    n := len(s)

    for size := minSize; size <= maxSize; size++ {
        for i := 0; i <= n-size; i++ {
            substring := s[i : i+size]
            letterCount := make(map[rune]int)
            for _, ch := range substring {
                letterCount[ch]++
            }
            if len(letterCount) <= maxLetters {
                freq[substring]++
            }
        }
    }

    maxCount := 0
    for _, count := range freq {
        if count > maxCount {
            maxCount = count
        }
    }

    return maxCount
}