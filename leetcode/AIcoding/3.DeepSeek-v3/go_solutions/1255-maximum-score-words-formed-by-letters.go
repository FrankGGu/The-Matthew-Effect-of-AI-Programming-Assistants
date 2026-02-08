func maxScoreWords(words []string, letters []byte, score []int) int {
    letterCount := make([]int, 26)
    for _, c := range letters {
        letterCount[c - 'a']++
    }

    maxScore := 0
    n := len(words)

    for mask := 0; mask < (1 << n); mask++ {
        currentCount := make([]int, 26)
        valid := true
        total := 0

        for i := 0; i < n; i++ {
            if mask & (1 << i) != 0 {
                for _, c := range words[i] {
                    idx := c - 'a'
                    currentCount[idx]++
                    if currentCount[idx] > letterCount[idx] {
                        valid = false
                        break
                    }
                    total += score[idx]
                }
                if !valid {
                    break
                }
            }
        }

        if valid && total > maxScore {
            maxScore = total
        }
    }

    return maxScore
}