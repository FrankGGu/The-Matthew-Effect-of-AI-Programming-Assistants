func mostVisited(n int, rounds []int) []int {
	start := rounds[0]
	end := rounds[len(rounds)-1]

	result := []int{}
	if start <= end {
		for i := start; i <= end; i++ {
			result = append(result, i)
		}
	} else {
		for i := 1; i <= end; i++ {
			result = append(result, i)
		}
		for i := start; i <= n; i++ {
			result = append(result, i)
		}
	}

	return result
}