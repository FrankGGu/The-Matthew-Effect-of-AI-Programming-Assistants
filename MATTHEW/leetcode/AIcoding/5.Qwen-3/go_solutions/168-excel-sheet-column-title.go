package leetcode

func convertToTitle(columnNumber int) string {
	var result string
	for columnNumber > 0 {
		columnNumber--
		result = string('A'+byte(columnNumber%26)) + result
		columnNumber /= 26
	}
	return result
}