func partitionLabels(s string) []int {
	last := make([]int, 26)
	for i := 0; i < len(s); i++ {
		last[s[i]-'a'] = i
	}

	result := []int{}
	start := 0
	end := 0
	for i := 0; i < len(s); i++ {
		end = max(end, last[s[i]-'a'])
		if i == end {
			result = append(result, end-start+1)
			start = i + 1
		}
	}
	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}