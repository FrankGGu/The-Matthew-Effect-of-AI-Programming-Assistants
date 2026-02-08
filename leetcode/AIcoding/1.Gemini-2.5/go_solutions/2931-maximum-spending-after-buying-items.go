package main

import (
	"sort"
)

func maxSpending(items [][]int) int64 {
	var allCosts []int
	for _, row := range items {
		for _, cost := range row {
			allCosts = append(allCosts, cost)
		}
	}

	sort.Ints(allCosts)

	var totalSpending int64
	// To maximize the sum of products (cost * day), we should pair the smallest costs
	// with the smallest day multipliers, and increasingly larger costs with increasingly
	// larger day multipliers.
	// The days are 1, 2, 3, ..., up to the total number of items.
	// Since `allCosts` is sorted in ascending order, `allCosts[i]` represents the (i+1)-th smallest cost.
	// We pair `allCosts[i]` with day `i+1`.
	for i := 0; i < len(allCosts); i++ {
		day := int64(i + 1)
		totalSpending += int64(allCosts[i]) * day
	}

	return totalSpending
}