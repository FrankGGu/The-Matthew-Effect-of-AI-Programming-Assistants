package main

func prefixScores(strings []string) []int {
    trie := make(map[string]int)
    for _, s := range strings {
        for i := 1; i <= len(s); i++ {
            prefix := s[:i]
            trie[prefix]++
        }
    }
    result := make([]int, len(strings))
    for i, s := range strings {
        score := 0
        for j := 1; j <= len(s); j++ {
            prefix := s[:j]
            score += trie[prefix]
        }
        result[i] = score
    }
    return result
}