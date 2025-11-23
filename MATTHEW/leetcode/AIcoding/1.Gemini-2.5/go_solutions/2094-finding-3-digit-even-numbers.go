package main

import (
	"sort"
)

func findEvenNumbers(digits []int) []int {
	counts := make([]int, 10)
	for _, digit := range digits {
		counts[digit]++
	}

	resultMap := make(map[int]bool)

	for h := 1; h <= 9; h++ {
		if counts[h] == 0 {
			continue
		}
		counts[h]--
		for t := 0; t <= 9; t++ {
			if counts[t] == 0 {
				continue
			}
			counts[t]--
			for u := 0; u <= 9; u += 2 { // Only even digits for units place
				if counts[u] == 0 {
					continue
				}
				num := h*100 + t*10 + u
				resultMap[num] = true
			}
			counts[t]++
		}
		counts[h]++
	}

	var result []int
	for num := range resultMap {
		result = append(result, num)
	}
	sort.Ints(result)
	return result
}