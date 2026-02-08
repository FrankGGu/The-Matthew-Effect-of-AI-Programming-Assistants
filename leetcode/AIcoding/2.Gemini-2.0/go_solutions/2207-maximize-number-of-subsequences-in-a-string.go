func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximumSubsequenceCount(text string, pattern string) int64 {
	first := pattern[0]
	second := pattern[1]

	count1 := int64(0)
	count2 := int64(0)
	res := int64(0)

	for i := 0; i < len(text); i++ {
		if text[i] == second {
			res += count1
			count2++
		}
		if text[i] == first {
			count1++
		}
	}

	return res + int64(max(int(count1), int(count2)))
}