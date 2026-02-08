func lengthOfLastWord(s string) int {
	n := len(s)
	length := 0
	for i := n - 1; i >= 0; i-- {
		if s[i] == ' ' {
			if length > 0 {
				return length
			}
		} else {
			length++
		}
	}
	return length
}