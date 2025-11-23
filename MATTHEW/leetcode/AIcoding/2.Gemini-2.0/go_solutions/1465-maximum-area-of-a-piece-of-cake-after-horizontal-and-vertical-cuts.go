import (
	"sort"
)

func maxArea(h int, w int, horizontalCuts []int, verticalCuts []int) int {
	sort.Ints(horizontalCuts)
	sort.Ints(verticalCuts)

	maxH := 0
	maxV := 0

	prev := 0
	for _, cut := range horizontalCuts {
		maxH = max(maxH, cut-prev)
		prev = cut
	}
	maxH = max(maxH, h-prev)

	prev = 0
	for _, cut := range verticalCuts {
		maxV = max(maxV, cut-prev)
		prev = cut
	}
	maxV = max(maxV, w-prev)

	return (maxH * maxV) % 1000000007
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}