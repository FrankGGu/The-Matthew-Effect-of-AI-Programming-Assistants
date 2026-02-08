func largestVariance(s string) int {
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }
    maxVariance := 0

    for a := 0; a < 26; a++ {
        for b := 0; b < 26; b++ {
            if a == b || count[a] == 0 || count[b] == 0 {
                continue
            }
            maxA, maxB := 0, -len(s)
            remainingB := count[b]
            for _, c := range s {
                current := int(c - 'a')
                if current == a {
                    maxA++
                    maxB++
                } else if current == b {
                    maxB = max(maxA-1, maxB-1)
                    maxA = 0
                    remainingB--
                }
                if maxB > maxVariance && maxA > 0 {
                    maxVariance = maxB
                }
                if maxA + remainingB <= maxVariance {
                    break
                }
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