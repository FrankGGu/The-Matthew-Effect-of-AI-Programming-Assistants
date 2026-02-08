package main

import "math"

func totalFruit(fruits []int) int {
	maxFruits := 0
	left := 0
	fruitCounts := make(map[int]int)

	for right := 0; right < len(fruits); right++ {
		fruitCounts[fruits[right]]++

		for len(fruitCounts) > 2 {
			fruitCounts[fruits[left]]--
			if fruitCounts[fruits[left]] == 0 {
				delete(fruitCounts, fruits[left])
			}
			left++
		}
		maxFruits = int(math.Max(float64(maxFruits), float64(right-left+1)))
	}

	return maxFruits
}