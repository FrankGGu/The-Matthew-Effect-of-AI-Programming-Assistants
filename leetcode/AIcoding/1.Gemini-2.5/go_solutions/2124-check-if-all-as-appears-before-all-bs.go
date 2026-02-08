func checkString(s string) bool {
	foundB := false
	for _, char := range s {
		if char == 'b' {
			foundB = true
		} else { // char == 'a'
			if foundB {
				return false
			}
		}
	}
	return true
}