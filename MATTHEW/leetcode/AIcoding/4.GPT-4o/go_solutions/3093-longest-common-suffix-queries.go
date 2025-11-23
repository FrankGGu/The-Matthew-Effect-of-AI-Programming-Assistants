package main

import "fmt"

type SuffixArray struct {
	suffixes []string
}

func NewSuffixArray(words []string) *SuffixArray {
	suffixes := make([]string, 0)
	for _, word := range words {
		for i := 0; i < len(word); i++ {
			suffixes = append(suffixes, word[i:])
		}
	}
	return &SuffixArray{suffixes: suffixes}
}

func (sa *SuffixArray) LongestCommonSuffix(query string) int {
	maxLength := 0
	for _, suffix := range sa.suffixes {
		lcs := longestCommonSuffix(query, suffix)
		if lcs > maxLength {
			maxLength = lcs
		}
	}
	return maxLength
}

func longestCommonSuffix(a, b string) int {
	i, j := len(a)-1, len(b)-1
	count := 0
	for i >= 0 && j >= 0 && a[i] == b[j] {
		count++
		i--
		j--
	}
	return count
}

func longestCommonSuffixQueries(words []string, queries []string) []int {
	suffixArray := NewSuffixArray(words)
	results := make([]int, len(queries))
	for i, query := range queries {
		results[i] = suffixArray.LongestCommonSuffix(query)
	}
	return results
}

func main() {
	words := []string{"flower", "flow", "flight"}
	queries := []string{"low", "fl", "ight"}
	results := longestCommonSuffixQueries(words, queries)
	fmt.Println(results)
}