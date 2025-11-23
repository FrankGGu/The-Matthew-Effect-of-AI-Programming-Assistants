func maxRepeating(sequence string, word string) int {
    maxCount := 0
    for i := 1; ; i++ {
        repeat := strings.Repeat(word, i)
        if strings.Contains(sequence, repeat) {
            maxCount = i
        } else {
            break
        }
    }
    return maxCount
}