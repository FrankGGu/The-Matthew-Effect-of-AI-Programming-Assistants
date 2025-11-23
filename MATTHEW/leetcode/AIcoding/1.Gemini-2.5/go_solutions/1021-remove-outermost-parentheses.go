import "strings"

func removeOuterParentheses(s string) string {
	var result strings.Builder
	balance := 0
	start := 0

	for i := 0; i < len(s); i++ {
		if s[i] == '(' {
			balance++
		} else { // s[i] == ')'
			balance--
		}

		if balance == 0 {
			// A primitive decomposition s[start : i+1] has been found.
			// Remove its outermost parentheses by taking the substring from start