func balancedStringSplit(s string) int {
	count := 0
	balance := 0
	for _, char := range s {
		if char == 'L' {
			balance++
		} else {
			balance--
		}
		if balance == 0 {
			count++
		}
	}
	return count
}