func canThreePartsEqualSum(arr []int) bool {
	sum := 0
	for _, num := range arr {
		sum += num
	}

	if sum%3 != 0 {
		return false
	}

	target := sum / 3
	count := 0
	currentSum := 0
	for _, num := range arr {
		currentSum += num
		if currentSum == target {
			count++
			currentSum = 0
		}
	}

	return count >= 3
}