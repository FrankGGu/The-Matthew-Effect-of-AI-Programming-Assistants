func rearrangeCharacters(s string, target string) int {
    sCount := make([]int, 26)
    targetCount := make([]int, 26)

    for _, ch := range s {
        sCount[ch - 'a']++
    }

    for _, ch := range target {
        targetCount[ch - 'a']++
    }

    minCopies := len(s)
    for i := 0; i < 26; i++ {
        if targetCount[i] > 0 {
            copies := sCount[i] / targetCount[i]
            if copies < minCopies {
                minCopies = copies
            }
        }
    }

    return minCopies
}