func splitSkills(skill string) []string {
	res := []string{}
	n := len(skill)
	if n == 0 {
		return res
	}

	var dfs func(string, []string)
	dfs = func(s string, cur []string) {
		if len(s) == 0 {
			res = append(res, cur...)
			return
		}

		for i := 1; i <= len(s); i++ {
			dfs(s[i:], append([]string{}, append(cur, s[:i])...))
		}
	}

	dfs(skill, []string{})
	return res
}