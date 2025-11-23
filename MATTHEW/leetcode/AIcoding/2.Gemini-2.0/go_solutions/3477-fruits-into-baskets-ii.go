func totalFruit(fruits []int) int {
	n := len(fruits)
	left := 0
	maxLen := 0
	fruitCount := make(map[int]int)
	fruitCount[fruits[0]] = 1
	count := 1

	for right := 1; right < n; right++ {
		if _, ok := fruitCount[fruits[right]]; !ok {
			fruitCount[fruits[right]] = 0
		}
		fruitCount[fruits[right]]++
		if fruitCount[fruits[right]] == 1 {
			count++
		}

		for count > 2 {
			fruitCount[fruits[left]]--
			if fruitCount[fruits[left]] == 0 {
				delete(fruitCount, fruits[left])
				count--
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