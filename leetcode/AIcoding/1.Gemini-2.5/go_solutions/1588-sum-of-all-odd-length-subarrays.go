func sumOddLengthSubarrays(arr []int) int {
	n := len(arr)
	totalSum := 0

	for i := 0; i < n; i++ {
		leftChoices := i + 1
		rightChoices := n - i

		numOddLeft := (leftChoices + 1) / 2
		numEvenLeft := leftChoices / 2

		numOddRight := (rightChoices + 1) / 2
		numEvenRight := rightChoices / 2

		countForI := numOddLeft*numOddRight + numEvenLeft*numEvenRight

		totalSum += arr[i] * countForI
	}

	return totalSum
}