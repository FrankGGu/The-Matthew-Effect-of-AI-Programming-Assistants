func canRearrangeKSubstrings(s string, k int, target string) bool {
    n := len(s)
    m := len(target)
    if n < m || m % k != 0 {
        return false
    }

    targetCount := make(map[rune]int)
    for _, ch := range target {
        targetCount[ch]++
    }

    substrCount := make(map[rune]int)
    for _, ch := range s {
        substrCount[ch]++
    }

    for ch, count := range targetCount {
        if substrCount[ch] < count {
            return false
        }
        substrCount[ch] -= count
    }

    totalAvailable := 0
    for _, count := range substrCount {
        totalAvailable += count
    }

    return totalAvailable % k == 0
}