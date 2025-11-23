package main

func maxScore(s string) int {
    maxScore := 0
    for i := 1; i < len(s); i++ {
        left := 0
        for j := 0; j < i; j++ {
            if s[j] == '0' {
                left++
            }
        }
        right := 0
        for j := i; j < len(s); j++ {
            if s[j] == '1' {
                right++
            }
        }
        currentScore := left + right
        if currentScore > maxScore {
            maxScore = currentScore
        }
    }
    return maxScore
}