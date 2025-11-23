func faultyKeyboard(s string) string {
	res := ""
	for _, c := range s {
		if c == 'i' {
			temp := ""
			for _, r := range res {
				temp = string(r) + temp
			}
			res = temp
		} else {
			res += string(c)
		}
	}
	return res
}