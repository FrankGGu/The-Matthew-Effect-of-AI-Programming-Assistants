func goodDaysToRobBank(security []int, time int) []int {
	n := len(security)
	result := []int{}
	if n < 2*time+1 {
		return result
	}

	left := make([]int, n)
	right := make([]int, n)

	for i := 1; i < n; i++ {
		if security[i] <= security[i-1] {
			left[i] = left[i-1] + 1
		}
		if security[n-1-i] <= security[n-i] {
			right[n-1-i] = right[n-i] + 1
		}
	}

	for i := time; i < n-time; i++ {
		if left[i] >= time && right[i] >= time {
			result = append(result, i)
		}
	}

	return result
}