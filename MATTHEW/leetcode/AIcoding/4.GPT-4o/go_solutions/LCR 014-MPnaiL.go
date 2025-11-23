package main

import (
	"sort"
	"strings"
)

func permutation(s string) []string {
	res := []string{}
	permute([]rune(s), 0, &res)
	sort.Strings(res)
	return res
}

func permute(s []rune, start int, res *[]string) {
	if start == len(s)-1 {
		*res = append(*res, string(s))
		return
	}
	seen := make(map[rune]bool)
	for i := start; i < len(s); i++ {
		if !seen[s[i]] {
			seen[s[i]] = true
			s[start], s[i] = s[i], s[start]
			permute(s, start+1, res)
			s[start], s[i] = s[i], s[start]
		}
	}
}