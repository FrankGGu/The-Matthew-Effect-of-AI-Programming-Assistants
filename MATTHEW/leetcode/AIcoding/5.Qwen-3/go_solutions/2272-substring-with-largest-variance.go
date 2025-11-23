package main

func maxSubstringWithLargestVariance(s string) int {
    maxVariance := 0
    uniqueChars := make(map[byte]bool)
    for i := range s {
        uniqueChars[s[i]] = true
    }
    for a := range uniqueChars {
        for b := range uniqueChars {
            if a == b {
                continue
            }
            var countA, countB, firstB bool
            for i := range s {
                if s[i] == a {
                    countA++
                } else if s[i] == b {
                    countB++
                    firstB = true
                }
                if countA < countB && firstB {
                    countA, countB = 0, 0
                }
            }
            if firstB && countA > 0 {
                maxVariance = max(maxVariance, countA-countB)
            }
        }
    }
    return maxVariance
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}