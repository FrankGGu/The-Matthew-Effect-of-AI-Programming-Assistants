package main

func maxCoinsFromKConsecutiveBags(bags []int, k int) int {
	n := len(bags)
	if n == 0 || k == 0 || k > n {
		return 0
	}

	currentSum := 0
	for i := 0; i < k; i++ {
		currentSum += bags[i]
	}

	maxSum := currentSum

	for i := k; i < n; i++ {
		currentSum += bags[i] - bags[i-k]
		if currentSum > maxSum {
			maxSum = currentSum
		}
	}

	return maxSum
}