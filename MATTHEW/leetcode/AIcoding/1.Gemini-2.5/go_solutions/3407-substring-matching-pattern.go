func strStr(haystack string, needle string) int {
	n := len(haystack)
	m := len(needle)

	if m == 0 {
		return 0
	}
	if n < m {
		return -1
	}

	lps := computeLPSArray(needle