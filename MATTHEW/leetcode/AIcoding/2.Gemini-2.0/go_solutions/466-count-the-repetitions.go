func getMaxRepetitions(s1 string, n1 int, s2 string, n2 int) int {
	len1, len2 := len(s1), len(s2)
	if len1 == 0 || len2 == 0 || n1 == 0 || n2 == 0 {
		return 0
	}

	repeatCount := make([]int, len2+1)
	nextIndex := make([]int, len2+1)
	j := 0
	count := 0

	for k := 1; k <= n1; k++ {
		for i := 0; i < len1; i++ {
			if s1[i] == s2[j] {
				j++
				if j == len2 {
					count++
					j = 0
				}
			}
		}
		repeatCount[k] = count
		nextIndex[k] = j

		for start := 0; start < k; start++ {
			if nextIndex[start] == j {
				prefixCount := repeatCount[start]
				patternCount := (repeatCount[k] - repeatCount[start]) * ((n1 - start) / (k - start))
				suffixCount := repeatCount[start+ (n1 - start) % (k - start)] - repeatCount[start]
				return (prefixCount + patternCount + suffixCount) / n2
			}
		}
	}

	return repeatCount[n1] / n2
}