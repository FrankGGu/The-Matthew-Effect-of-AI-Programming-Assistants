func findTheMinimumPossibleSum(n int, target int) int64 {
	var sum int64
	chosen := make(map[int]bool)
	count := 0
	currentNum := 1

	for count < n {
		if !chosen[target-currentNum] {
			sum += int64(currentNum)
			chosen[currentNum] = true
			count++
		}
		currentNum++
	}

	return sum
}