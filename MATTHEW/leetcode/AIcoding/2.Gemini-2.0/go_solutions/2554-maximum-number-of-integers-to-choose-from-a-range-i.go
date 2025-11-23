func maxCount(banned []int, n int, maxSum int) int {
	banMap := make(map[int]bool)
	for _, num := range banned {
		banMap[num] = true
	}

	count := 0
	sum := 0
	for i := 1; i <= n; i++ {
		if !banMap[i] {
			if sum+i <= maxSum {
				sum += i
				count++
			} else {
				break
			}
		}
	}

	return count
}