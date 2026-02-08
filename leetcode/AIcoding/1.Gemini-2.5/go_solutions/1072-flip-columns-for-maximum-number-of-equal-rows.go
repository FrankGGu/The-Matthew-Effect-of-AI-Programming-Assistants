package main

import (
	"strconv"
	"strings"
)

func maxEqualRowsAfterFlips(matrix [][]int) int {
	counts := make(map[string]int)
	maxCount := 0

	for _, row := range matrix {
		var sb strings.Builder
		shouldFlip := row[0] == 1

		for _, val := range row {
			if shouldFlip {
				sb.WriteString(strconv.Itoa(1 - val))
			} else {
				sb.WriteString(strconv.Itoa(val))
			}
		}
		normalizedRowStr := sb.String()
		counts[normalizedRowStr]++
		if counts[normalizedRowStr] > maxCount {
			maxCount = counts[normalizedRowStr]
		}
	}

	return maxCount
}