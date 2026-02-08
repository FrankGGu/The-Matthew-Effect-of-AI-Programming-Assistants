func findTheLongestSubstring(s string) int {
    state := 0
    firstOccurrence := make([]int, 32)
    for i := range firstOccurrence {
        firstOccurrence[i] = -1
    }
    firstOccurrence[0] = 0
    maxLen := 0
    vowels := map[byte]int{'a': 0, 'e': 1, 'i': 2, 'o': 3, 'u': 4}

    for i := 0; i < len(s); i++ {
        if idx, ok := vowels[s[i]]; ok {
            state ^= 1 << idx
        }
        if firstOccurrence[state] == -1 {
            firstOccurrence[state] = i + 1
        } else {
            if i + 1 - firstOccurrence[state] > maxLen {
                maxLen = i + 1 - firstOccurrence[state]
            }
        }
    }
    return maxLen
}