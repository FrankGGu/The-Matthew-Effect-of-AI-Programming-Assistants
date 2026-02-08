func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxTotalFruits(fruits [][]int, startPosition int, k int) int {
	n := len(fruits)
	left := 0
	right := 0
	sum := 0
	ans := 0

	for right < n {
		sum += fruits[right][1]

		for left <= right && fruits[right][0]-fruits[left][0]+min(abs(fruits[right][0]-startPosition), abs(fruits[left][0]-startPosition)) > k {
			sum -= fruits[left][1]
			left++
		}

		ans = max(ans, sum)
		right++
	}

	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}