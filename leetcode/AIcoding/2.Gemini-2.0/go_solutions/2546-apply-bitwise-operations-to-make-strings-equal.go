func makeStringsEqual(s string, target string) bool {
	sHasOne := false
	targetHasOne := false
	for i := 0; i < len(s); i++ {
		if s[i] == '1' {
			sHasOne = true
		}
		if target[i] == '1' {
			targetHasOne = true
		}
	}
	if sHasOne == targetHasOne {
		return true
	}
	return false
}