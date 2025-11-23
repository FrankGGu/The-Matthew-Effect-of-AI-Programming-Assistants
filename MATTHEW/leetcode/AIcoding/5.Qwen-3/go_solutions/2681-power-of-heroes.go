package main

func maxPower(s string) int {
    maxPower := 1
    currentPower := 1

    for i := 1; i < len(s); i++ {
        if s[i] == s[i-1] {
            currentPower++
            if currentPower > maxPower {
                maxPower = currentPower
            }
        } else {
            currentPower = 1
        }
    }

    return maxPower
}