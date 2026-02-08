func relativeSortArray(arr1 []int, arr2 []int) []int {
	counts := make([]int, 1001) // Max value is 1000
	for _, num := range arr1 {
		counts[num]++
	}

	result := make([]int, 0, len(arr1))

	for _, num := range arr2 {
		for i := 0; i < counts[num]; i++ {
			result = append(result, num)
		}
		counts[num] = 0 // Mark as processed
	}

	for i := 0; i <= 1000; i++ {
		for j := 0; j < counts[i]; j++ {
			result = append(result, i)
		}
	}

	return result
}