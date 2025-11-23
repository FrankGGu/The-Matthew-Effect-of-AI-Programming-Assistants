package main

func wordBreak(s string, wordDict []string) []string {
    wordSet := make(map[string]bool)
    for _, word := range wordDict {
        wordSet[word] = true
    }
    memo := make(map[string][]string)
    return dfs(s, wordSet, memo)
}

func dfs(s string, wordSet map[string]bool, memo map[string][]string) []string {
    if res, found := memo[s]; found {
        return res
    }
    if len(s) == 0 {
        return []string{""}
    }
    result := []string{}
    for i := 1; i <= len(s); i++ {
        prefix := s[:i]
        if wordSet[prefix] {
            suffixes := dfs(s[i:], wordSet, memo)
            for _, suffix := range suffixes {
                if suffix == "" {
                    result = append(result, prefix)
                } else {
                    result = append(result, prefix+" "+suffix)
                }
            }
        }
    }
    memo[s] = result
    return result
}