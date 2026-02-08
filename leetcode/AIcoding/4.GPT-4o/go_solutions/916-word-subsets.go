func wordSubsets(A []string, B []string) []string {
    bCount := make([]int, 26)
    for _, word := range B {
        count := make([]int, 26)
        for _, ch := range word {
            count[ch-'a']++
        }
        for i := 0; i < 26; i++ {
            bCount[i] = max(bCount[i], count[i])
        }
    }

    var result []string
    for _, word := range A {
        count := make([]int, 26)
        for _, ch := range word {
            count[ch-'a']++
        }
        if isValid(count, bCount) {
            result = append(result, word)
        }
    }
    return result
}

func isValid(count []int, bCount []int) bool {
    for i := 0; i < 26; i++ {
        if count[i] < bCount[i] {
            return false
        }
    }
    return true
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}