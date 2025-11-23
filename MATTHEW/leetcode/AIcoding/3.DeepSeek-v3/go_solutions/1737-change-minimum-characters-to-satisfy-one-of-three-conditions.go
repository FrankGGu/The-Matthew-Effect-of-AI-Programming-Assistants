func minCharacters(a string, b string) int {
    countA := make([]int, 26)
    countB := make([]int, 26)

    for _, c := range a {
        countA[c-'a']++
    }
    for _, c := range b {
        countB[c-'a']++
    }

    res := math.MaxInt32

    // Case 3: all a[i] == b[j]
    for i := 0; i < 26; i++ {
        res = min(res, len(a) + len(b) - countA[i] - countB[i])
    }

    // Case 1: a < b
    res = min(res, calculate(countA, countB))

    // Case 2: b < a
    res = min(res, calculate(countB, countA))

    return res
}

func calculate(countA, countB []int) int {
    res := math.MaxInt32
    for i := 1; i < 26; i++ {
        sum := 0
        for j := i; j < 26; j++ {
            sum += countA[j]
        }
        for j := 0; j < i; j++ {
            sum += countB[j]
        }
        res = min(res, sum)
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}