func reformat(s string) string {
	digits := []rune{}
	letters := []rune{}

	for _, r := range s {
		if unicode.IsDigit(r) {
			digits = append(digits, r)
		} else {
			letters