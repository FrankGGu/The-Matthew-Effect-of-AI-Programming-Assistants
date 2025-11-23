package main

func wordBreak(s string, wordDict []string) bool {
    wordSet := make(map[string]bool)
    for _, word := range wordDict {
        wordSet[word] = true
    }
    memo := make(map[int]bool)
    var dfs func(int) bool
    dfs = func(start int) bool {
        if start == len(s) {
            return true
        }
        if val, ok := memo[start]; ok {
            return val
        }
        for end := start + 1; end <= len(s); end++ {
            if wordSet[s[start:end]] && dfs(end) {
                memo[start] = true
                return true
            }
        }
        memo[start] = false
        return false
    }
    return dfs(0)
}