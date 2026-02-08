func maximum69Number(num int) int {
	s := strconv.Itoa(num)
	for i := 0; i < len(s); i++ {
		if s[i] == '6' {
			s = s[:i] + "9" + s[i+1:]
			break
		}
	}
	result, _ := strconv.Atoi(s)
	return result
}