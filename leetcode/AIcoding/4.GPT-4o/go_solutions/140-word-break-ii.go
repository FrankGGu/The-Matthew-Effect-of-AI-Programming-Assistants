func wordBreak(s string, wordDict []string) []string {
    wordSet := make(map[string]struct{})
    for _, word := range wordDict {
        wordSet[word] = struct{}{}
    }

    memo := make(map[string][]string)
    var dfs func(string) []string
    dfs = func(substring string) []string {
        if res, ok := memo[substring]; ok {
            return res
        }
        if substring == "" {
            return []string{""}
        }
        var results []string
        for i := 1; i <= len(substring); i++ {
            prefix := substring[:i]
            if _, exists := wordSet[prefix]; exists {
                suffixResults := dfs(substring[i:])
                for _, suffix := range suffixResults {
                    if suffix == "" {
                        results = append(results, prefix)
                    } else {
                        results = append(results, prefix+" "+suffix)
                    }
                }
            }
        }
        memo[substring] = results
        return results
    }

    return dfs(s)
}