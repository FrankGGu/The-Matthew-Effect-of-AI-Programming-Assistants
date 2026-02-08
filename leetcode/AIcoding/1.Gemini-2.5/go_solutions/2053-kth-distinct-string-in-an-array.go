func kthDistinct(arr []string, k int) string {
	freq := make(map[string]int)
	for _, s := range arr {
		freq[s]++
	}

	for _, s := range arr {
		if freq[s] == 1 {
			k--
			if k == 0 {
				return s
			}
		}
	}

	return ""
}