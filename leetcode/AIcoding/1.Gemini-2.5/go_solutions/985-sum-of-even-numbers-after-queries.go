func sumEvenAfterQueries(nums []int, queries [][]int) []int {
	currentEvenSum := 0
	for _, num := range nums {
		if num%2 == 0 {
			currentEvenSum += num
		}
	}

	results := make([]int, len(queries))

	for i, query := range queries {
		val := query[0]
		index := query[1]

		// If the number at index was even, subtract it from currentEvenSum
		if nums[index]%2 == 0 {
			currentEvenSum -= nums[index]
		}

		// Update the number
		nums[index] += val

		// If the new number at index is even, add it to currentEvenSum
		if nums[index]%2 == 0 {
			currentEvenSum += nums[index]
		}

		results[i] = currentEvenSum
	}

	return results
}