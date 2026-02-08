func minAddToMakeValid(s string) int {
	balance := 0
	count := 0
	for _, char := range s {
		if char == '(' {
			balance++
		} else {
			if balance > 0 {
				balance--
			} else {
				count++
			}
		}
	}
	return count + balance
}