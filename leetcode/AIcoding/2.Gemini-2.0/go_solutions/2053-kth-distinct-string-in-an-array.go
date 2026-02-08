func kthDistinct(arr []string, k int) string {
	counts := make(map[string]int)
	for _, s := range arr {
		counts[s]++
	}

	distinctCount := 0
	for _, s := range arr {
		if counts[s] == 1 {
			distinctCount++
			if distinctCount == k {
				return s
			}
		}
	}

	return ""
}