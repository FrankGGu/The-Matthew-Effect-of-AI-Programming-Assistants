package main

import (
	"sort"
)

func mostBeautifulItem(items [][]int, queries []int) []int {
	sort.Slice(items, func(i, j int) bool {
		return items[i][0] < items[j][0]
	})

	type Query struct {
		maxPrice int
		index    int
	}

	augmentedQueries := make([]Query, len(queries))
	for i, q := range queries {
		augmentedQueries[i] = Query{maxPrice: q, index: i}
	}

	sort.Slice(augmentedQueries, func(i, j int) bool {
		return augmentedQueries[i].maxPrice < augmentedQueries[j].maxPrice
	})

	ans := make([]int, len(queries))
	itemIdx := 0
	currentMaxBeauty := 0

	for _, q := range augmentedQueries {
		for itemIdx < len(items) && items[itemIdx][0] <= q.maxPrice {
			if items[itemIdx][1] > currentMaxBeauty {
				currentMaxBeauty = items[itemIdx][1]
			}
			itemIdx++
		}
		ans[q.index] = currentMaxBeauty
	}

	return ans
}