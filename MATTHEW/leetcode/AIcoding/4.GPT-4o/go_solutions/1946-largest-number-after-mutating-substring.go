func maximumNumber(num string, change []int) string {
    n := len(num)
    numBytes := []byte(num)
    mutated := false
    for i := 0; i < n; i++ {
        digit := int(numBytes[i] - '0')
        if change[digit] > digit {
            numBytes[i] = byte(change[digit] + '0')
            mutated = true
        } else if change[digit] < digit && mutated {
            break
        }
    }
    for i := n - 1; i >= 0; i-- {
        digit := int(numBytes[i] - '0')
        if change[digit] < digit {
            break
        }
        if change[digit] > digit {
            numBytes[i] = byte(change[digit] + '0')
        }
    }
    return string(numBytes)
}