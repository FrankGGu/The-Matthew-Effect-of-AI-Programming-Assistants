package main

func countPrefixSuffixPairs(n int, words []string) int {
    count := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if len(words[i]) <= len(words[j]) && len(words[j]) >= len(words[i]) {
                if len(words[i]) == 0 {
                    continue
                }
                if words[j][len(words[i])-1] == words[i][len(words[i])-1] && words[j][0] == words[i][0] {
                    count++
                }
            }
        }
    }
    return count
}