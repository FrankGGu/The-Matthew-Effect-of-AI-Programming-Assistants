func wordBreak(s string, wordDict []string) []string {
    wordSet := make(map[string]bool)
    for _, word := range wordDict {
        wordSet[word] = true
    }
    memo := make(map[int][]string)
    return dfs(s, wordSet, 0, memo)
}

func dfs(s string, wordSet map[string]bool, start int, memo map[int][]string) []string {
    if res, ok := memo[start]; ok {
        return res
    }
    res := []string{}
    if start == len(s) {
        res = append(res, "")
        return res
    }
    for end := start + 1; end <= len(s); end++ {
        word := s[start:end]
        if wordSet[word] {
            list := dfs(s, wordSet, end, memo)
            for _, l := range list {
                if l == "" {
                    res = append(res, word)
                } else {
                    res = append(res, word+" "+l)
                }
            }
        }
    }
    memo[start] = res
    return res
}