package main

import (
	"sort"
	"strconv"
	"strings"
)

func findCategoryRecommendationPairs(recommendations [][]string) [][]string {
	userToCategories := make(map[string][]string)

	for _, rec := range recommendations {
		userID := rec[0]
		category := rec[1]
		userToCategories[userID] = append(userToCategories[userID], category)
	}

	pairCounts := make(map[string]int)

	for _, categories := range userToCategories {
		if len(categories) < 2 {
			continue
		}

		sort.Strings(categories)

		for i := 0; i < len(categories)-1; i++ {
			for j := i + 1; j < len(categories); j++ {
				cat1 := categories[i]
				cat2 := categories[j]
				pairKey := cat1 + "_" + cat2
				pairCounts[pairKey]++
			}
		}
	}

	var result [][]string
	for pairKey, count := range pairCounts {
		parts := strings.Split(pairKey, "_")
		cat1 := parts[0]
		cat2 := parts[1]
		result = append(result, []string{cat1, cat2, strconv.Itoa(count)})
	}

	sort.Slice(result, func(a, b int) bool {
		if result[a][0] != result[b][0] {
			return result[a][0] < result[b][0]
		}
		return result[a][1] < result[b][1]
	})

	return result
}