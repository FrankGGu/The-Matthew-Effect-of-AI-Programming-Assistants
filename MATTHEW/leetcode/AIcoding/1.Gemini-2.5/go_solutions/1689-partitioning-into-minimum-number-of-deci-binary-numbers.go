func minPartitions(n string) int {
    maxDigit := 0
    for _, char := range n {
        digit := int(char - '0')
        if digit > maxDigit {
            maxDigit = digit
        }
    }
    return maxDigit
}