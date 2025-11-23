func minPartitions(n string) int {
    maxDigit := '0'
    for _, ch := range n {
        if ch > maxDigit {
            maxDigit = ch
        }
    }
    return int(maxDigit - '0')
}