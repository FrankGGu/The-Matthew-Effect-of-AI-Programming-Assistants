func titleToNumber(columnTitle string) int {
	result := 0
	for _, c := range columnTitle {
		result = result*26 + int(c-'A'+1)
	}
	return result
}