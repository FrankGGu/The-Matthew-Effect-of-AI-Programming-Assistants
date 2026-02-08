package main

import "sort"

func maximumWhiteTiles(tiles [][]int, carpetLen int) int {
	sort.Slice(tiles, func(i, j int) bool {
		return tiles[i][0] < tiles[j][0]
	})

	n := len(tiles)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + tiles[i][1] - tiles[i][0] + 1
	}

	maxTiles := 0
	left := 0

	for right := 0; right < n; right++ {
		for left <= right && tiles[right][1]-tiles[left][0]+1 > carpetLen {
			left++
		}
		totalCovered := prefixSum[right+1] - prefixSum[left]
		if left > 0 {
			totalCovered += min(carpetLen-(tiles[right][0]-tiles[left-1][1]-1), tiles[left-1][1]-tiles[left-1][0]+1)
		}
		maxTiles = max(maxTiles, totalCovered)
	}

	return maxTiles
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}