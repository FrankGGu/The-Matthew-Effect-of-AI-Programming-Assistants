func generate(n int) []string {
	if n == 0 {
		return []string{""}
	}
	if n == 1 {
		return []string{"0", "1"}
	}

	res := []string{}
	var backtrack func(string, int)

	backtrack = func(s string, k int) {
		if k == n {
			res = append(res, s)
			return
		}

		if len(s) > 0 && s[len(s)-1] == '0' {
			backtrack(s+"1", k+1)
		} else {
			backtrack(s+"0", k+1)
			backtrack(s+"1", k+1)
		}
	}

	backtrack("", 0)
	return res
}