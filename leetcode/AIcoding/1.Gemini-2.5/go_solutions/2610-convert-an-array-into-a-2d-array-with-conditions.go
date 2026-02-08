package main

func findMatrix(nums []int) [][]int {
	result := [][]int{}

	freq := make(map[int]int) 

	for _, num := range nums {
		rowIdx := freq[num]

		if rowIdx == len(result) {
			result = append(result, []int{})
		}

		result[rowIdx] = append(result[rowIdx], num)

		freq[num]++
	}

	return result
}