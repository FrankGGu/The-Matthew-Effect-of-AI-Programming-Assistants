func removeDigit(number string, digit byte) string {
    maxResult := ""
    n := len(number)

    for i := 0; i < n; i++ {
        if number[i] == digit {
            newNumber := number[:i] + number[i+1:]
            if newNumber > maxResult {
                maxResult = newNumber
            }
        }
    }

    return maxResult
}