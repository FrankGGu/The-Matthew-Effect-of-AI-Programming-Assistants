package main

import "math"

func totalFruit(fruits []int) int {
	if len(fruits) <= 2 {
		return len(fruits)
	}

	fruitCount := make(map[int]int)
	left := 0
	maxLen := 0

	for right := 0; right < len(fruits); right++ {
		fruitCount[fruits[right]]++

		for len(fruitCount) > 2 {
			fruitCount[fruits[left]]--
			if fruitCount[fruits[left]] == 0 {
				delete(fruitCount, fruits[left])
			}
			left++
		}
		maxLen = int(math.Max(float64(maxLen), float64(right-left+1)))
	}

	return maxLen
}