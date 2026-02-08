func evaluate(s string, knowledge [][]string) string {
	m := make(map[string]string)
	for _, k := range knowledge {
		m[k[0]] = k[1]
	}

	res := ""
	inBracket := false
	key := ""
	for _, c := range s {
		if c == '(' {
			inBracket = true
			key = ""
		} else if c == ')' {
			inBracket = false
			if val, ok := m[key]; ok {
				res += val
			} else {
				res += "?"
			}
		} else {
			if inBracket {
				key += string(c)
			} else {
				res += string(c)
			}
		}
	}

	return res
}