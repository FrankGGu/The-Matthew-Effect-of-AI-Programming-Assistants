package main

func minimumOperations(nums []int) int {
	uniquePositiveNumbers := make(map[int]bool)
	for _, num := range nums {
		if num > 0 {
			uniquePositiveNumbers[num] = true
		}
	}
	return len(uniquePositiveNumbers)
}