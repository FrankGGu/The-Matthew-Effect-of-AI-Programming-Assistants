func findTheLongestBalancedSubstring(s string) int {
	maxLen := 0
	n := len(s)
	i := 0

	for i < n {
		if s[i] == '1' {
			i++
			continue
		}

		zeros := 0
		j := i
		for j < n && s[j] == '0' {
			zeros++
			j++
		}

		ones := 0
		k := j
		for k < n && s[k] == '1' {
			ones++
			k++
		}

		currentLen := 0
		if zeros < ones {
			currentLen = zeros * 2
		} else {
			currentLen = ones * 2
		}

		if currentLen > maxLen {
			maxLen = currentLen
		}

		i = k
	}

	return maxLen
}