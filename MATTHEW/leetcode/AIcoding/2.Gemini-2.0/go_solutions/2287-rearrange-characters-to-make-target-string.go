func rearrangeCharacters(s string, target string) int {
    sCount := make(map[rune]int)
    targetCount := make(map[rune]int)

    for _, c := range s {
        sCount[c]++
    }

    for _, c := range target {
        targetCount[c]++
    }

    ans := int(^uint(0) >> 1) // Max int

    for char, count := range targetCount {
        sCharCount, ok := sCount[char]
        if !ok {
            return 0
        }
        ans = min(ans, sCharCount/count)
    }

    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}