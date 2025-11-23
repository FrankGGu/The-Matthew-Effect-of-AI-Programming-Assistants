func longestCommonSuffix(queries [][]int, text string) []int {
	n := len(text)
	results := make([]int, len(queries))
	for i, query := range queries {
		l := query[0]
		r := query[1]
		length := 0
		for j := 0; j < min(r-l+1, n-r); j++ {
			if text[r-j] == text[n-1-j] {
				length++
			} else {
				break
			}
		}
		results[i] = length
	}
	return results
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}