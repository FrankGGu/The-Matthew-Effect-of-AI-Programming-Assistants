func pyramidTransition(bottom string, allowed []string) bool {
	m := make(map[string][]byte)
	for _, s := range allowed {
		m[s[:2]] = append(m[s[:2]], s[2])
	}

	var dfs func(string) bool
	dfs = func(bottom string) bool {
		if len(bottom) == 1 {
			return true
		}

		next := make([]string, 1)
		next[0] = ""

		for i := 0; i < len(bottom)-1; i++ {
			key := bottom[i:i+2]
			options := m[key]
			if len(options) == 0 {
				return false
			}

			temp := make([]string, 0)
			for _, s := range next {
				for _, c := range options {
					temp = append(temp, s+string(c))
				}
			}
			next = temp
		}

		for _, s := range next {
			if dfs(s) {
				return true
			}
		}

		return false
	}

	return dfs(bottom)
}