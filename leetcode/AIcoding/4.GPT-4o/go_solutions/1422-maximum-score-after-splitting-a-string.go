func maximumScore(s string) int {
    countA, countB, maxScore := 0, 0, 0

    for _, char := range s {
        if char == 'a' {
            countA++
        } else {
            countB++
        }
    }

    for i := 0; i < len(s); i++ {
        if s[i] == 'a' {
            countA--
        } else {
            countB--
        }
        score := countA + (countB + 1)
        if score > maxScore {
            maxScore = score
        }

        countA, countB = 0, 0
        for j := i + 1; j < len(s); j++ {
            if s[j] == 'a' {
                countA++
            } else {
                countB++
            }
        }
    }

    return maxScore
}