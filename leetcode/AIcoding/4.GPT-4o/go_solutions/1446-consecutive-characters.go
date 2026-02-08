func maxPower(s string) int {
    maxPower := 1
    currentPower := 1

    for i := 1; i < len(s); i++ {
        if s[i] == s[i-1] {
            currentPower++
        } else {
            if currentPower > maxPower {
                maxPower = currentPower
            }
            currentPower = 1
        }
    }

    if currentPower > maxPower {
        maxPower = currentPower
    }

    return maxPower
}