package main

import (
	"strings"
)

func wordBreak(s string, wordDict []string) []string {
	wordSet := make(map[string]struct{})
	for _, word := range wordDict {
		wordSet[word] = struct{}{}
	}

	memo := make(map[int][]string)

	var dfs func(start int) []string
	dfs = func(start int) []string {
		if start == len(s) {
			return []string{""}
		}

		if res, found := memo[start]; found {
			return res
		}

		var results []string
		for i := start; i < len(s); i++ {
			word := s[start : i+1]
			if _, exists := wordSet[word]; exists {
				subSentences := dfs(i + 1)
				for _, sub := range subSentences {
					if sub == "" {
						results = append(results, word)
					} else {
						results = append(results, word+" "+sub)
					}
				}
			}
		}

		memo[start] = results
		return results
	}

	return dfs(0)
}