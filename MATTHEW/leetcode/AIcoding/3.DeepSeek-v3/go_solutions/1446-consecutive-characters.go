func maxPower(s string) int {
    maxCount := 1
    currentCount := 1

    for i := 1; i < len(s); i++ {
        if s[i] == s[i-1] {
            currentCount++
            if currentCount > maxCount {
                maxCount = currentCount
            }
        } else {
            currentCount = 1
        }
    }

    return maxCount
}