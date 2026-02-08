func countSeniors(details []string) int {
	count := 0
	for _, detail := range details {
		age := (int(detail[11]-'0') * 10) + int(detail[12]-'0')
		if age > 60 {
			count++
		}
	}
	return count
}