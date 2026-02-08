func percentageOfLetter(s string, letter byte) float64 {
    count := 0
    for i := 0; i < len(s); i++ {
        if s[i] == letter {
            count++
        }
    }
    return float64(count) / float64(len(s)) * 100
}