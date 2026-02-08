package main

import (
	"sort"
)

func findRecommendationPairs(orders [][]int, minSupport int) [][]int {
	pairCounts := make(map[[2]int]int)

	for _, order := range orders {
		uniqueProductsMap := make(map[int]bool)
		for _, product := range order {
			uniqueProductsMap[product] = true
		}

		uniqueProductsSlice := make([]int, 0, len(uniqueProductsMap))
		for product := range uniqueProductsMap {
			uniqueProductsSlice = append(uniqueProductsSlice, product)
		}

		sort.Ints(uniqueProductsSlice)

		n := len(uniqueProductsSlice)
		for i := 0; i < n; i++ {
			for j := i + 1; j < n; j++ {
				p1 := uniqueProductsSlice[i]
				p2 := uniqueProductsSlice[j]
				pair := [2]int{p1, p2}
				pairCounts[pair]++
			}
		}
	}

	result := make([][]int, 0)
	for pair, count := range pairCounts {
		if count >= minSupport {
			result = append(result, []int{pair[0], pair[1]})
		}
	}

	sort.Slice(result, func(a, b int) bool {
		if result[a][0] != result[b][0] {
			return result[a][0] < result[b][0]
		}
		return result[a][1] < result[b][1]
	})

	return result
}