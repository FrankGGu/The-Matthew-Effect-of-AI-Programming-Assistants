func minCharacters(a string, b string) int {
    countA := [26]int{}
    countB := [26]int{}

    for _, ch := range a {
        countA[ch-'a']++
    }
    for _, ch := range b {
        countB[ch-'a']++
    }

    totalA := len(a)
    totalB := len(b)
    result := totalA + totalB

    for i := 0; i < 26; i++ {
        total := countA[i] + countB[i]
        if total > 0 {
            result = min(result, totalA+totalB-total)
        }
    }

    for i := 1; i < 26; i++ {
        countA[i] += countA[i-1]
        countB[i] += countB[i-1]
        result = min(result, totalA-countA[i]+totalB-countB[i])
    }

    return result
}

func min(x, y int) int {
    if x < y {
        return x
    }
    return y
}