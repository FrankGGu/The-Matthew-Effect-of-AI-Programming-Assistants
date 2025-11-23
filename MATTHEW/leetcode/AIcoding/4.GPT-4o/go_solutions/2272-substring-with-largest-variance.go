func largestVariance(s string) int {
    maxVar := 0
    uniqueChars := make(map[rune]bool)

    for _, char := range s {
        uniqueChars[char] = true
    }

    for a := range uniqueChars {
        for b := range uniqueChars {
            if a == b {
                continue
            }

            countA, countB := 0, 0
            tempMax := 0
            for _, char := range s {
                if char == a {
                    countA++
                }
                if char == b {
                    countB++
                }

                if countB > 0 {
                    tempMax = max(tempMax, countA-countB)
                }

                if countA < countB {
                    countA, countB = 0, 0
                }
            }

            if countA > 0 && countB > 0 {
                maxVar = max(maxVar, tempMax)
            }
        }
    }

    return maxVar
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}