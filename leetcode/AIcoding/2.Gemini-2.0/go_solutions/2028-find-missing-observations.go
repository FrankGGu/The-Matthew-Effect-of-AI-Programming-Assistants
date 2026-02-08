func missingRolls(rolls []int, mean int, n int) []int {
	m := len(rolls)
	sum := 0
	for _, roll := range rolls {
		sum += roll
	}
	missingSum := mean*(n+m) - sum
	if missingSum < n || missingSum > 6*n {
		return []int{}
	}
	result := make([]int, n)
	base := missingSum / n
	remainder := missingSum % n
	for i := 0; i < n; i++ {
		result[i] = base
		if i < remainder {
			result[i]++
		}
	}
	return result
}