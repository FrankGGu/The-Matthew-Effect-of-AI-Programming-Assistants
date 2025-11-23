func decodeAtIndex(s string, k int) string {
	size := 0
	for _, c := range s {
		if '0' <= c && c <= '9' {
			num := int(c - '0')
			size *= num
		} else {
			size++
		}
	}

	for i := len(s) - 1; i >= 0; i-- {
		k %= size
		if k == 0 && !('0' <= s[i] && s[i] <= '9') {
			return string(s[i])
		}

		if '0' <= s[i] && s[i] <= '9' {
			num := int(s[i] - '0')
			size /= num
		} else {
			size--
		}
	}

	return ""
}