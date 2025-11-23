package main

func canThreePartsEqualSum(arr []int) bool {
	totalSum := 0
	for _, num := range arr {
		totalSum += num
	}

	if totalSum%3 != 0 {
		return false
	}

	targetSum := totalSum / 3
	currentSum := 0
	partsFound := 0

	for _, num := range arr {
		currentSum += num
		if currentSum == targetSum {
			partsFound++
			currentSum = 0
		}
	}

	return partsFound >= 3
}