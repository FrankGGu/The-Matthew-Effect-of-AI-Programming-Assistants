func parseBoolExpr(expression string) bool {
	var eval func(string) bool
	eval = func(s string) bool {
		if s == "t" {
			return true
		}
		if s == "f" {
			return false
		}

		op := s[0]
		content := s[2 : len(s)-1]

		var exprs []string
		cnt := 0
		start := 0
		for i := 0; i < len(content); i++ {
			if content[i] == '(' {
				cnt++
			} else if content[i] == ')' {
				cnt--
			} else if content[i] == ',' && cnt == 0 {
				exprs = append(exprs, content[start:i])
				start = i + 1
			}
		}
		exprs = append(exprs, content[start:])

		switch op {
		case '&':
			res := true
			for _, expr := range exprs {
				res = res && eval(expr)
			}
			return res
		case '|':
			res := false
			for _, expr := range exprs {
				res = res || eval(expr)
			}
			return res
		case '!':
			return !eval(exprs[0])
		}
		return false
	}

	return eval(expression)
}