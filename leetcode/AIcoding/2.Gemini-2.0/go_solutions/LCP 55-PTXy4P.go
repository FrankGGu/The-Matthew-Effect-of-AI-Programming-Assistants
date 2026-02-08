func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxTotalFruits(fruits [][]int, startPos int, k int) int {
	n := len(fruits)
	left := 0
	right := 0
	currSum := 0
	maxFruits := 0

	for right < n {
		currSum += fruits[right][1]

		for left <= right && (min(abs(fruits[right][0]-startPos), abs(fruits[left][0]-startPos))+abs(fruits[right][0]-fruits[left][0])) > k {
			currSum -= fruits[left][1]
			left++
		}

		maxFruits = max(maxFruits, currSum)
		right++
	}

	return maxFruits
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