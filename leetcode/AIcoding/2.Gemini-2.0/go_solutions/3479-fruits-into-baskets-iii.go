func totalFruit(fruits []int) int {
	maxLen := 0
	left := 0
	fruitMap := make(map[int]int)

	for right := 0; right < len(fruits); right++ {
		fruitMap[fruits[right]]++

		for len(fruitMap) > 2 {
			fruitMap[fruits[left]]--
			if fruitMap[fruits[left]] == 0 {
				delete(fruitMap, fruits[left])
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