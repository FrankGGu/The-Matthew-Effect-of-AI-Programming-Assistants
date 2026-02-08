func maximumNumber(num string, change []int) string {
    numBytes := []byte(num)
    mutated := false
    for i := 0; i < len(numBytes); i++ {
        original := int(numBytes[i] - '0')
        newDigit := change[original]
        if newDigit > original {
            numBytes[i] = byte(newDigit + '0')
            mutated = true
        } else if newDigit == original {
            continue
        } else {
            if mutated {
                break
            }
        }
    }
    return string(numBytes)
}