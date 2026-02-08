func canConstruct(blocks []string, target string) bool {
    blockCount := make(map[rune]int)
    for _, block := range blocks {
        for _, char := range block {
            blockCount[char]++
        }
    }

    targetCount := make(map[rune]int)
    for _, char := range target {
        targetCount[char]++
    }

    for char, count := range targetCount {
        if blockCount[char] < count {
            return false
        }
    }

    return true
}