package main

func longestCommonPrefix(strs []string, k int, x int) string {
	if k == 0 || len(strs) == 0 {
		return ""
	}

	if k > len(strs) {
		k = len(strs)
	}

	processedStrs := make([]string, k)
	for i := 0; i < k; i++ {
		if len(strs[i]) <= x {
			processedStrs[i] = ""
		} else {
			processedStrs[i] = strs[i][x:]
		}
	}

	if len(processedStrs) == 0 {
		return ""
	}

	minLength := len(processedStrs[0])
	for i := 1; i < len(processedStrs); i++ {
		if len(processedStrs[i]) < minLength {
			minLength = len(processedStrs[i])
		}
	}

	for j := 0; j < minLength; j++ {
		char := processedStrs[0][j]
		for i := 1; i < len(processedStrs); i++ {
			if processedStrs[i][j] != char {
				return processedStrs[0][:j]
			}
		}
	}

	return processedStrs[0][:minLength]
}