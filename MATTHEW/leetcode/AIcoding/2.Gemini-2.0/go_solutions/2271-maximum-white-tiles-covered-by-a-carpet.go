func maximumWhiteTiles(tiles [][]int, carpetLen int) int {
	sort.Slice(tiles, func(i, j int) bool {
		return tiles[i][0] < tiles[j][0]
	})

	n := len(tiles)
	ans := 0
	j := 0
	currLen := 0

	for i := 0; i < n; i++ {
		for j < n && tiles[j][1] < tiles[i][0]+carpetLen {
			currLen += tiles[j][1] - tiles[j][0] + 1
			j++
		}

		coveredLen := currLen
		if j < n && tiles[i][0]+carpetLen <= tiles[j][1] {
			coveredLen += carpetLen - (tiles[j-1][1] - tiles[i][0] + 1) - (tiles[i][0] - tiles[i][0])
			coveredLen = min(coveredLen, tiles[j][1] - tiles[i][0] + 1)
			coveredLen = min(coveredLen, carpetLen)

		} else if j < n {
			coveredLen += min(carpetLen - (tiles[j-1][1] - tiles[i][0] + 1) - (tiles[i][0] - tiles[i][0]), tiles[j][1] - tiles[j][0] + 1)
		}

		ans = max(ans, coveredLen)

		currLen -= tiles[i][1] - tiles[i][0] + 1
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}