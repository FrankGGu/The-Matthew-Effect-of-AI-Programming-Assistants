func numSplits(s string) int {
    leftCount := make([]int, len(s))
    rightCount := make([]int, len(s))

    leftSet := make(map[rune]bool)
    rightSet := make(map[rune]bool)

    for i, ch := range s {
        leftSet[ch] = true
        leftCount[i] = len(leftSet)
    }

    for i := len(s) - 1; i >= 0; i-- {
        ch := rune(s[i])
        rightSet[ch] = true
        rightCount[i] = len(rightSet)
    }

    goodWays := 0
    for i := 0; i < len(s)-1; i++ {
        if leftCount[i] == rightCount[i+1] {
            goodWays++
        }
    }

    return goodWays
}