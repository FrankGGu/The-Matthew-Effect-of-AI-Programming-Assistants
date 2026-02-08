func longestCommonPrefix(strs []string) int {
	if len(strs) == 0 {
		return 0
	}

	if len(strs) == 1 {
		return len(strs[0])
	}

	firstStr := strs[0]

	for i := 0; i < len(firstStr); i++ {
		char := firstStr[i]
		for j := 1; j < len(strs); j++ {
			if i == len(strs[j]) || strs[j][i] != char {
				return i
			}
		}
	}

	return len(firstStr)
}