package main

import (
	"fmt"
	"strings"
)

func removeInvalidParentheses(s string) []string {
	var results []string
	minRemove := countInvalid(s)

	var dfs func(string, int, int, int, string)
	dfs = func(s string, last_i, last_j, paren_count int, expr string) {
		if paren_count < 0 {
			return
		}
		if last_j == len(s) {
			if paren_count == 0 && len(expr) == len(s)-minRemove {
				results = append(results, expr)
			}
			return
		}
		for i := last_i; i <= last_j; i++ {
			if i != last_i && s[i] == s[last_i] {
				continue
			}
			if s[i] == '(' {
				dfs(s, i, last_j, paren_count+1, expr+s[:i]+s[i+1:])
			} else if s[i] == ')' {
				dfs(s, i, last_j, paren_count-1, expr+s[:i]+s[i+1:])
			}
		}
	}

	dfs(s, 0, len(s)-1, 0, "")
	return results
}

func countInvalid(s string) int {
	count := 0
	for _, char := range s {
		if char == '(' {
			count++
		} else if char == ')' {
			count--
		}
		if count < 0 {
			count = 0
		}
	}
	return count + (count % 2)
}

func main() {
	s := "(a)())()"
	result := removeInvalidParentheses(s)
	fmt.Println(result)
}