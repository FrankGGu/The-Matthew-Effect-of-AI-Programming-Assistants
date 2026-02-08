package main

import (
	"sort"
)

func mostBeautifulItem(items [][]int, queries []int) []int {
	sort.Slice(items, func(i, j int) bool {
		if items[i][0] == items[j][0] {
			return items[i][1] > items[j][1]
		}
		return items[i][0] < items[j][0]
	})

	n := len(queries)
	res := make([]int, n)
	beautifulItems := make([]int, len(items))
	for i := 0; i < len(items); i++ {
		if i == 0 {
			beautifulItems[i] = items[i][1]
		} else {
			beautifulItems[i] = max(beautifulItems[i-1], items[i][1])
		}
	}

	for i, query := range queries {
		index := sort.Search(len(items), func(i int) bool {
			return items[i][0] > query
		})
		if index == 0 {
			res[i] = 0
		} else {
			res[i] = beautifulItems[index-1]
		}
	}

	return res
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}