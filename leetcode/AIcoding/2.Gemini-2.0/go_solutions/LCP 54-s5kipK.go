func captureForts(forts []int) int {
	maxLen := 0
	last := -1
	for i, fort := range forts {
		if fort != 0 {
			if last != -1 && forts[last] != fort {
				length := i - last - 1
				if length > maxLen {
					maxLen = length
				}
			}
			last = i
		}
	}
	return maxLen
}