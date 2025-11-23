package main

import (
	"sort"
)

func findArray(n int, sums []int) []int {
	ans := make([]int, 0, n)
	currentSums := sums

	for i := 0; i < n; i++ {
		sort.Ints(currentSums)

		diff := currentSums[1] - currentSums[0]

		newSumsIfDiff, okDiff := extractSums(currentSums, diff)

		if okDiff {
			ans = append(ans, diff)
			currentSums = newSumsIfDiff
		} else {
			newSumsIfNegDiff, okNegDiff := extractSums(currentSums, -diff)
			if !okNegDiff {
				// This path should not be reached given the problem guarantees.
				// One of 'diff' or '-diff' must always be a valid element.
				panic("Neither diff nor -diff worked, contradiction to problem statement")
			}
			ans = append(ans, -diff)
			currentSums = newSumsIfNegDiff
		}
	}

	return ans
}

func extractSums(allSums []int, val int) ([]int, bool) {
	newSums := make([]int, 0, len(allSums)/2)
	counts := make(map[int]int)
	for _, s := range allSums {
		counts[s]++
	}

	for _, s := range allSums {
		if counts[s] > 0 {
			newSums = append(newSums, s)
			counts[s]--

			if counts[s+val] > 0 {
				counts[s+val]--
			} else {
				return nil, false
			}
		}
	}
	return newSums, true
}