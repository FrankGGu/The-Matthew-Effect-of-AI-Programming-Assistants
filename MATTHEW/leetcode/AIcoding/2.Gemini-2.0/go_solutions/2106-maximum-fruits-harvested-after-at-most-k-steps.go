import "sort"

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

func maxTotalFruits(fruits [][]int, startPos int, k int) int {
	n := len(fruits)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + fruits[i][1]
	}

	ans := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			left := fruits[i][0]
			right := fruits[j][0]
			dist := 0

			if startPos >= left && startPos <= right {
				dist = right - left + min(startPos-left, right-startPos)
			} else if startPos < left {
				dist = right - startPos + min(right-left, startPos-left)
			} else {
				dist = startPos - left + min(right-left, startPos-right)
			}

			if dist <= k {
				ans = max(ans, prefixSum[j+1]-prefixSum[i])
			}
		}
	}

	return ans
}