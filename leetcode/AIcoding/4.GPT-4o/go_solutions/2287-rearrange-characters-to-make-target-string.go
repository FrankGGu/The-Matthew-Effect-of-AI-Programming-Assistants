func rearrangeCharacters(s string, target string) int {
    sCount := make([]int, 26)
    targetCount := make([]int, 26)

    for _, char := range s {
        sCount[char-'a']++
    }
    for _, char := range target {
        targetCount[char-'a']++
    }

    minCount := int(^uint(0) >> 1)
    for i := 0; i < 26; i++ {
        if targetCount[i] > 0 {
            minCount = min(minCount, sCount[i]/targetCount[i])
        }
    }

    return minCount
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}