func distinctSubseqII(s string) int {
	const MOD = 1_000_000_007

	lastCharCount := make([]int, 26)
	totalCount := 0

	for _, char := range s {
		charIdx := char - 'a'

		oldTotalCount := totalCount

		totalCount = (2*totalCount + 1) % MOD

		if lastCharCount[charIdx] > 0 {
			totalCount = (totalCount - lastCharCount[charIdx] + MOD) % MOD
		}

		lastCharCount[charIdx] = (oldTotalCount + 1) % MOD
	}

	return totalCount
}