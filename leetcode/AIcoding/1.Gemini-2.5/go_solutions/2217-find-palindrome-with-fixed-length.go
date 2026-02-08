func kthPalindrome(queries []int, intLength int) []int64 {
	ans := make([]int64, len(queries))

	halfLen := (intLength + 1) / 2
	startVal := int64(1)