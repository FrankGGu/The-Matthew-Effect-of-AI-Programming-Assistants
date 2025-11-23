func totalFruit(fruits []int) int {
	left, maxLen := 0, 0
	count := make(map[int]int)

	for right := 0; right < len(fruits); right++ {
		count[fruits[right]]++

		for len(count) > 2 {
			count[fruits[left]]--
			if count[fruits[left]] == 0 {
				delete(count, fruits[left])
			}
			left++
		}

		maxLen = max(maxLen, right-left+1)
	}

	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}