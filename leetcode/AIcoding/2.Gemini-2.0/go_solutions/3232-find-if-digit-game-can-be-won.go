func digitGame(n string) bool {
	m := len(n)
	if m%2 == 1 {
		if (m+1)/2 > int(n[m-1]-'0') {
			return true
		}
		return false
	}
	sum := 0
	for i := 0; i < m; i += 2 {
		sum += int(n[i] - '0')
	}
	for i := 1; i < m; i += 2 {
		sum -= int(n[i] - '0')
	}
	return sum >= 0
}