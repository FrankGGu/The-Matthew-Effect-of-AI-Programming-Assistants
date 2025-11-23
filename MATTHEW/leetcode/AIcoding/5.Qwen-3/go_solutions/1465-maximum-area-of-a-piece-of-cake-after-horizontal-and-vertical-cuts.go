package main

func maxArea(h int, w int, horizontalCuts []int, verticalCuts []int) int {
	sort.Ints(horizontalCuts)
	sort.Ints(verticalCuts)
	maxH := 0
	for i := 0; i < len(horizontalCuts); i++ {
		if i == 0 {
			maxH = horizontalCuts[i]
		} else {
			maxH = max(maxH, horizontalCuts[i]-horizontalCuts[i-1])
		}
	}
	maxH = max(maxH, h-horizontalCuts[len(horizontalCuts)-1])
	maxV := 0
	for i := 0; i < len(verticalCuts); i++ {
		if i == 0 {
			maxV = verticalCuts[i]
		} else {
			maxV = max(maxV, verticalCuts[i]-verticalCuts[i-1])
		}
	}
	maxV = max(maxV, w-verticalCuts[len(verticalCuts)-1])
	return (maxH * maxV) % (1000000007)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}