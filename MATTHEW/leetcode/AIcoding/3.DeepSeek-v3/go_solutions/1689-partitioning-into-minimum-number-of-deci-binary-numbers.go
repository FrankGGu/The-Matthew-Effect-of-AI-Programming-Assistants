func minPartitions(n string) int {
    maxDigit := 0
    for _, ch := range n {
        digit := int(ch - '0')
        if digit > maxDigit {
            maxDigit = digit
        }
    }
    return maxDigit
}