package main

import (
	"sort"
)

func maxProfit(colors []int, numWanted int, useLimit int) int {
	colorCount := make(map[int]int)
	for _, color := range colors {
		colorCount[color]++
	}

	var counts []int
	for _, count := range colorCount {
		counts = append(counts, count)
	}

	sort.Sort(sort.Reverse(sort.IntSlice(counts)))

	profit := 0
	ballsUsed := 0

	for _, count := range counts {
		if ballsUsed >= numWanted {
			break
		}
		take := min(count, useLimit, numWanted-ballsUsed)
		profit += take * (count - (count - take))
		ballsUsed += take
	}

	return profit
}

func min(a, b, c int) int {
	if a < b {
		if a < c {
			return a
		}
		return c
	}
	if b < c {
		return b
	}
	return c
}