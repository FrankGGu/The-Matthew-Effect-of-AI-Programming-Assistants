package main

func numberOfHiddenSequences(differences []int, lower int, upper int) int {
	l := int64(lower)
	u := int64(upper)

	currentDiffSum := int64(0)
	minVal := int64(0)
	maxVal := int64(0)

	for _, diff := range differences {
		currentDiffSum += int64(diff)
		if currentDiffSum < minVal {
			minVal = currentDiffSum
		}
		if currentDiffSum > maxVal {
			maxVal = currentDiffSum
		}
	}

	lowerBound := l - minVal
	upperBound := u - maxVal

	if lowerBound > upperBound {
		return 0
	}

	return int(upperBound - lowerBound + 1)
}