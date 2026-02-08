func generateParenthesis(n int) []string {
	result := []string{}
	var generate func(string, int, int)
	generate = func(s string, open int, close int) {
		if len(s) == 2*n {
			result = append(result, s)
			return
		}
		if open < n {
			generate(s+"(", open+1, close)
		}
		if close < open {
			generate(s+")", open, close+1)
		}
	}
	generate("", 0, 0)
	return result
}