package main

func findTheLongestSubstring(s string) int {
    mapVowel := map[byte]int{'a': 0, 'e': 1, 'i': 2, 'o': 3, 'u': 4}
    state := 0
    indexMap := make(map[int]int)
    indexMap[0] = -1
    maxLen := 0

    for i := 0; i < len(s); i++ {
        c := s[i]
        if _, ok := mapVowel[c]; ok {
            state ^= (1 << mapVowel[c])
        }
        if idx, ok := indexMap[state]; ok {
            maxLen = max(maxLen, i-idx)
        } else {
            indexMap[state] = i
        }
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}